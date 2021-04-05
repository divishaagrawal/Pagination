import UIKit

final class RepositoryListViewController: UIViewController {
    private var viewModel: RepositoryListViewModel?
    private var dataSource: RepositoryListDataSource?
    // if empty list is received after some number of pages, then  api will not be called
    private var shouldCallForNextData = true

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Jake's Git"
        view.backgroundColor = .white

        setUpView()
        setUpConstraints()

        setupDataSource()

        viewModel = RepositoryListViewModel(completion: { [weak self] response in
            guard let self = self else { return }
            guard let response = response else { return }
            switch response {
            case let .list(list, shouldCallForNextData):
                self.shouldCallForNextData = shouldCallForNextData
                if let response = list {
                    self.updateDataSource(with: response[0].repoList.map { $0 })
                }
                if !shouldCallForNextData, list != nil {
                    self.createAlert(msg: "There are no more items in the list...")
                }
            case let .error(error):
                self.createAlert(msg: error)
            }
            self.hideLoader()
        })
        fetchData()
    }

    private func createAlert(msg: String) {
        DispatchQueue.main.async {
            // Create new Alert
            let dialogMessage = UIAlertController(title: "Alert!",
                                                  message: msg,
                                                  preferredStyle: .alert)

            // Create OK button with action handler
            let okAction = UIAlertAction(title: "Okay",
                                         style: .default,
                                         handler: nil)

            // Add OK button to a dialog message
            dialogMessage.addAction(okAction)
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
}

private extension RepositoryListViewController {
    func setUpView() {
        view.addSubview(tableView)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    func setupDataSource() {
        let dataSource = RepositoryListDataSource(delegate: self)
        self.dataSource = dataSource
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        dataSource.register(for: tableView)
    }

    func updateDataSource(with list: [DatabaseModel]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.dataSource?.updateData(with: list)
            self.tableView.reloadData()
        }
    }
}

extension RepositoryListViewController: RepositoryListDataSourceDelegate {
    func fetchData() {
        if shouldCallForNextData {
            viewModel?.fetchData()
        } else {
            hideLoader()
        }
    }

    private func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.tableFooterView = nil
        }
    }
}
