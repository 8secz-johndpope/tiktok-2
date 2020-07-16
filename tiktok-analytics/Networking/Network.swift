import Alamofire

class Network {
    
    enum NetworkError: Error {
        case noDataOrError
    }

    struct StatusCodeError: LocalizedError {
        let code: Int

        var errorDescription: String? {
            return "An error occurred communicating with the server. Please try again."
        }
    }
    
    class func getUser(user: String, _ completion: @escaping (Result<Profile, Error>) -> Void) {
        let request = ApiRequest.user(user: user)
        AF.request(request.path, parameters: request.params).validate(statusCode: 200..<300).response { response in
            let result: Result<Profile, Error>
            switch response.result {
            case .success:
                guard let json = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? [String : Any],
                    let dataJson = json["data"] as? [String: Any],
                    let dataUser = try? JSONSerialization.data(withJSONObject: dataJson, options: []),
                    let user = try? JSONDecoder().decode(Profile.self, from: dataUser) else {
                        result = .failure(NetworkError.noDataOrError)
                        completion(result)
                        return
                }
                result = .success(user)
                completion(result)
            case .failure:
                result = .failure(StatusCodeError(code: response.response!.statusCode))
                completion(result)
            }
        }
    }
    
    class func getVideos(userId: Int, limit: Int = UIDevice.current.isPad ? 9 : 6, sort: String, _ completion: @escaping (Result<[Video], Error>) -> Void)  {
        let request = ApiRequest.videos(userId: userId, limit: limit, sort: sort)
        AF.request(request.path, parameters: request.params).validate(statusCode: 200..<300).response { response in
            let result: Result<[Video], Error>
            switch response.result {
            case .success:
                guard let json = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? [String : Any],
                    let dataJson = json["data"] as? [Any],
                    let dataVideos = try? JSONSerialization.data(withJSONObject: dataJson, options: []),
                    let videos = try? JSONDecoder().decode([Video].self, from: dataVideos) else {
                        result = .failure(NetworkError.noDataOrError)
                        completion(result)
                        return
                }
                result = .success(videos)
                completion(result)
            case .failure:
                result = .failure(StatusCodeError(code: response.response!.statusCode))
                completion(result)
            }
        }
    }
}
