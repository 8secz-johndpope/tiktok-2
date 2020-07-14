import Foundation

struct Profile: Model {
    var id: Int
    var login: String
    var nickname: String
    var bio: String
    var avatar: URL
    var following: Int
    var followers: Int
    var followers_lost: Int
    var followers_gained: Int
    var likes: Int
    var videos: Int
}
