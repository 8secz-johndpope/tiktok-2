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
    
    var avatarData: Data? {
        return try? Data(contentsOf: avatar)
    }
}

extension Int {
    var formatted: String {
        switch self {
        case 0...1000:
            return "\(self)"
        case 1001...9999:
            return "\(digits[0])K"
        case 10000...99999:
            return "\(digits[0])\(digits[1])K"
        case 100000...999999:
            return "\(digits[0])\(digits[1])\(digits[2])K"
        case 1000000...9999999:
            return "\(digits[0])M"
        case 10000000...99999999:
            return "\(digits[0])\(digits[1])M"
        case 100000000...999999999:
            return "\(digits[0])\(digits[1])\(digits[2])M"
        default: return "999M+"
        }
    }
    
    var digits: [Int] {
        return "\(self)".compactMap({ $0.wholeNumberValue })
    }
}
