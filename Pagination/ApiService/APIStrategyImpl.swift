import Foundation

class APIStrategyImpl: APIStrategy {
    typealias Parameters = [String: String]
    func fetchList(parameter: Parameters,
                   completion: @escaping (Result<RepositoryItems, PError>) -> Void) {
        guard let url = getRequest(parameter: parameter) else {
            completion(.failure(.customError))
            return
        }
        URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            if let error = error {
                completion(.failure(.backendError(error.localizedDescription)))
                return
            }
            guard let data = data,
                  let response = urlResponse as? HTTPURLResponse,
                  (200..<300) ~= response.statusCode,
                  error == nil else {
                completion(.failure(.customError))
                return
            }
            let jsonDecoder = JSONDecoder()
            do {
                let data = try jsonDecoder.decode(RepositoryItems.self, from: data)
                completion(.success(data))
            } catch {
                print("\(error)")
                completion(.failure(.customError))
            }
        }.resume()
    }

    func getRequest(parameter: Parameters) -> URLRequest? {
        let urlString = "https://api.github.com/users/JakeWharton/repos"
        var components = URLComponents(string: urlString)
        components?.queryItems = parameter.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        if let url = components?.url {
            return URLRequest(url: url)
        }
        return nil
    }
}
