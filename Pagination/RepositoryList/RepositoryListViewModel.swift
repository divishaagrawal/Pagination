import Foundation
import Network
import RealmSwift

enum RepositoryResponse {
    case list(Results<DatabaseItem>?, Bool)
    case error(String)
}

final class RepositoryListViewModel {
    private var pageNo = 1 // starting from page number 1
    private let apiService: APIStrategy
    private var result: RepositoryResponse? {
        didSet {
            dataCompletion(result)
        }
    }

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "InternetConnectionMonitor")

    private let dataCompletion: (RepositoryResponse?) -> Void

    init(completion: @escaping (RepositoryResponse?) -> Void) {
        apiService = APIStrategyImpl()
        dataCompletion = completion
    }

    func fetchData() {
        // if no internet, return data from realm else proceed with API call
        monitor.pathUpdateHandler = { [weak self] pathUpdateHandler in
            guard let self = self else { return }
            if pathUpdateHandler.status == .satisfied {
                self.apiService.fetchList(parameter: self.fetchPageParameters) { result in
                    switch result {
                    case let .success(value):
                        DispatchQueue.main.async {
                            if self.pageNo == 1 {
                                DataHolder.sharedInstance.deleteData()
                            }
                            DataHolder.sharedInstance.writeData(data: self.processData(response: value))
                            self.result = .list(DataHolder.sharedInstance.readData(), !value.isEmpty)
                            self.pageNo += 1
                        }
                    case let .failure(error):
                        self.result = .error(error.localizedDescription)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.result = .list(DataHolder.sharedInstance.readData(), true)
                }
            }
        }

        monitor.start(queue: queue)
    }

    // process the response received
    private func processData(response: RepositoryItems) -> List<DatabaseModel> {
        let list = List<DatabaseModel>()
        for item in response {
            let model = DatabaseModel()
            model.name = item.name
            model.desc = item.description ?? ""
            let iconTextList = List<ItemModel>()
            if let language = item.language {
                iconTextList.append(ItemModel(iconName: "bracket", value: language))
            }
            iconTextList.append(ItemModel(iconName: "bug", value: "\(item.openIssuesCount)"))
            iconTextList.append(ItemModel(iconName: "watcher", value: "\(item.watchersCount)"))
            model.items = iconTextList
            list.append(model)
        }
        return list
    }

    // parameters to be added in the url
    private var fetchPageParameters: [String: String] {
        var dict: [String: String] = [:]
        dict["page"] = "\(pageNo)"
        dict["per_page"] = "15"
        return dict
    }
}
