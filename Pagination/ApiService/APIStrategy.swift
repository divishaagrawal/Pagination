
protocol APIStrategy {
    func fetchList(parameter: [String: String],
                   completion: @escaping (Result<RepositoryItems, PError>) -> Void)
}

enum PError: Error {
    case customError
    case backendError(String)

    var localizedDescription: String {
        switch self {
        case .customError:
            return "Something went wrong please try again..."
        case let .backendError(error):
            return error
        }
    }
}
