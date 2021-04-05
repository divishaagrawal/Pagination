import UIKit

protocol RepositoryListDataSourceDelegate: AnyObject {
    func fetchData()
}

final class RepositoryListDataSource: NSObject {
    private static let lastApiConstant = 3
    private weak var delegate: RepositoryListDataSourceDelegate?
    private var list: [DatabaseModel] = []

    init(delegate: RepositoryListDataSourceDelegate?) {
        self.delegate = delegate
    }

    func updateData(with list: [DatabaseModel]) {
        self.list = list
    }

    func register(for tableView: UITableView) {
        tableView.register(RepositoryListItemCell.self)
    }
}

extension RepositoryListDataSource: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(RepositoryListItemCell.self)
        cell.selectionStyle = .none
        cell.configCell(data: list[indexPath.row])
        cell.accessibilityIdentifier = "kIdRepositoryViewCell"
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row > list.count - RepositoryListDataSource.lastApiConstant {
            let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
            if indexPath.row == lastRowIndex {
                let spinner = UIActivityIndicatorView(style: .medium)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0),
                                       y: CGFloat(0),
                                       width: tableView.bounds.width,
                                       height: CGFloat(44))
                tableView.tableFooterView = spinner
                tableView.tableFooterView?.isHidden = false
            }
            delegate?.fetchData()
        }
    }
}
