import UIKit

class HeaderView: UIView {

    @IBOutlet weak var folowingCountLabel: UILabel!
    @IBOutlet weak var folowingTitleLabel: UILabel! {
        didSet {
            folowingTitleLabel.text = Localization.following
        }
    }
    
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followersTitleLabel: UILabel! {
        didSet {
            followersTitleLabel.text = Localization.followers
        }
    }
    
    @IBOutlet weak var heartsCountLabel: UILabel!
    @IBOutlet weak var heartsTitleLabel: UILabel! {
        didSet {
            heartsTitleLabel.text = Localization.hearts
        }
    }
    
    func setup(withProfile profile: Profile) {
        folowingCountLabel.text = profile.following.formatted
        followersCountLabel.text = profile.followers.formatted
        heartsCountLabel.text = profile.likes.formatted
    }
}
