import UIKit

extension UITableView: ViewIdentifier {
    // helpful in case cell is used before being registered
    func dequeueReusableCell<T: UITableViewCell>(_ cellClass: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier) as? T else {
            fatalError("\(T.self) Please register the cell before use")
        }

        return cell
    }

    // register cell
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
}

extension UITableViewCell: ViewIdentifier {}

protocol ViewIdentifier: class {
    static var reuseIdentifier: String {
        get
    }
}

extension ViewIdentifier {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
}

extension UIView {
    func removeAllSubviews() {
        subviews.forEach {
            $0.removeAllSubviews()
            $0.removeFromSuperview()
        }
    }
}
