typealias RepositoryItems = [RepositoryItemModel]

struct RepositoryItemModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case name, description
        case watchersCount = "watchers_count"
        case openIssuesCount = "open_issues_count"
        case language
    }

    let name: String
    let description: String?
    let watchersCount: Int
    let openIssuesCount: Int
    let language: String?
}
