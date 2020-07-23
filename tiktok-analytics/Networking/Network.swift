import Alamofire

class Network {

    struct StatusCodeError: Error {
        let code: Int
        
        var localizedDescription: String {
            return Localization.notFound
        }
    }
    
    class func getUser(user: String, _ completion: @escaping (Result<Profile, StatusCodeError>) -> Void) {
        let request = ApiRequest.user(user: user)
        AF.request(request.path, parameters: request.params).validate(statusCode: 200..<300).response { response in
            let result: Result<Profile, StatusCodeError>
//            
//            
//            let result1: Result<Profile, Error> = .success(Profile(id: 1, login: "login", nickname: "nickname", bio: "bio", avatar: nil, following: 10000, followers: 10000, followers_lost: 100, followers_gained: 100, likes: 10, videos: 3))
//            completion(result1)
//            return
            
            switch response.result {
            case .success:
                guard let responseData = response.data,
                    let json = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String : Any],
                    let dataJson = json["data"] as? [String: Any],
                    let dataUser = try? JSONSerialization.data(withJSONObject: dataJson, options: []),
                    let user = try? JSONDecoder().decode(Profile.self, from: dataUser) else {
                        result = .failure(StatusCodeError(code: 0))
                        completion(result)
                        return
                }
                result = .success(user)
                completion(result)
            case .failure(let error):
                result = .failure(StatusCodeError(code: error.responseCode ?? 0))
                completion(result)
            }
        }
    }
    
    class func getVideos(userId: Int, limit: Int = UIDevice.current.isPad ? 9 : 6, sort: String, _ completion: @escaping (Result<[Video], StatusCodeError>) -> Void)  {
        let request = ApiRequest.videos(userId: userId, limit: limit, sort: sort)
        AF.request(request.path, parameters: request.params).validate(statusCode: 200..<300).response { response in
            let result: Result<[Video], StatusCodeError>
            switch response.result {
            case .success:
                guard let responseData = response.data,
                let json = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String : Any],
                    let dataJson = json["data"] as? [Any],
                    let dataVideos = try? JSONSerialization.data(withJSONObject: dataJson, options: []),
                    let videos = try? JSONDecoder().decode([Video].self, from: dataVideos) else {
                        result = .failure(StatusCodeError(code: 0))
                        completion(result)
                        return
                }
                result = .success(videos)
                completion(result)
            case .failure(let error):
                result = .failure(StatusCodeError(code: error.responseCode ?? 0))
                completion(result)
            }
        }
    }
}
