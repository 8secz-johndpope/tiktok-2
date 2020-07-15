import UIKit

class HeaderView: UIView {

    @IBOutlet weak var folowingCountLabel: UILabel!
    @IBOutlet weak var folowingTitleLabel: UILabel!
    
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followersTitleLabel: UILabel!
    
    @IBOutlet weak var heartsCountLabel: UILabel!
    @IBOutlet weak var heartsTitleLabel: UILabel!
    
    func setup(withProfile profile: Profile) {
        folowingCountLabel.text = profile.following.formatted
        followersCountLabel.text = profile.followers.formatted
        heartsCountLabel.text = profile.likes.formatted
    }
}
