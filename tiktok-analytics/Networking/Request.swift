import Foundation

protocol Requestable {
    func urlRequest() -> URLRequest
}

struct Request: Requestable {
    let path: String
    let method: String

    init(path: String, method: String = "GET") {
        self.path = path
        self.method = method
    }

    func urlRequest() -> URLRequest {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com")?.appendingPathComponent(path) else {
            return URLRequest(url: URL(fileURLWithPath: ""))
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method

        return urlRequest
    }
}

struct PostRequest<Model: Encodable>: Requestable {
    let path: String
    let model: Model

    func urlRequest() -> URLRequest {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com")?.appendingPathComponent(path) else {
            return URLRequest(url: URL(fileURLWithPath: ""))
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"

        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(model)
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        } catch let error {
            print(error)
        }

        return urlRequest
    }
}

extension URLRequest: Requestable {
    func urlRequest() -> URLRequest {
        return self
    }
}
