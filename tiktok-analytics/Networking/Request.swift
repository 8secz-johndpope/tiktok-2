import Alamofire

enum ApiRequest {
    case user(user: String)
    case videos(userId: Int, limit: Int, sort: String)
    
    var path: String {
    switch self {
    case .user(let user):
        return Constants.apiUrl + "/user/\(user)"
    case .videos(let userId, _, _):
        return Constants.apiUrl + "/user/\(userId)/videos"
        }
    }
    
    var params: Parameters? {
        var parameters = Parameters()
        parameters["key"] = Constants.apiKey
        switch self {
        case .videos(_, let limit, let sort):
            parameters["limit"] = limit
            parameters["sort_by"] = sort
        default: break
        }
        return parameters
    }
}
