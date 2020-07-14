import Foundation

class Network {
    static let shared = Network()

    private let queue = DispatchQueue(label: "SimpleNetwork", qos: .userInitiated, attributes: .concurrent)

    enum NetworkError: Error {
        case noDataOrError
    }

    struct StatusCodeError: LocalizedError {
        let code: Int

        var errorDescription: String? {
            return "An error occurred communicating with the server. Please try again."
        }
    }

    let session: URLSession = URLSession(configuration: .default)

    func send<T: Model>(_ request: Requestable, completion: @escaping (Result<T, Error>)->Void) {
        // Go to a background queue as request.urlRequest() may do json parsing
        queue.async {
            let urlRequest = request.urlRequest()

            print("Send: \(urlRequest.url?.absoluteString ?? "") - \(urlRequest.httpMethod ?? "")")

            // Send the request
            let task = self.session.dataTask(with: urlRequest) { data, response, error in
                let result: Result<T, Error>

                if let error = error {
                    // First, check if the network just returned an error
                    result = .failure(error)
                } else if let error = self.error(from: response) {
                    // Next, check if the status code was valid
                    result = .failure(error)
                } else if let data = data {
                    // Otherwise, let's try parsing the data
                    do {
                        let decoder = JSONDecoder()
                        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                            let dataJson = json["data"] as? [String: Any],
                            let dataUser = try? JSONSerialization.data(withJSONObject: dataJson, options: []),
                            let user = try? decoder.decode(T.self, from: dataUser) else {
                                result = .failure(NetworkError.noDataOrError)
                                completion(result)
                                return
                        }
                        result = .success(user)
                    } catch {
                        result = .failure(error)
                    }
                } else {
                    print("oops")
                    result = .failure(NetworkError.noDataOrError)
                }

                DispatchQueue.main.async {
                    completion(result)
                }
            }

            task.resume()
        }
    }

    private func error(from response: URLResponse?) -> Error? {
        guard let response = response as? HTTPURLResponse else {
            print("Missing http response when trying to parse a status code.")
            return nil
        }

        let statusCode = response.statusCode

        if statusCode >= 200 && statusCode <= 299 {
            return nil
        } else {
            print("Invalid status code from \(response.url?.absoluteString ?? "unknown"): \(statusCode)")
            return StatusCodeError(code: statusCode)
        }
    }
}

