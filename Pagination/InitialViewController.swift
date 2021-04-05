import UIKit

class InitialViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapViewList(_ sender: Any) {
        let viewController = RepositoryListViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
