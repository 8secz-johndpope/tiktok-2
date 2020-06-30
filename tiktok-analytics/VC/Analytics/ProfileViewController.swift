import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = 22.0
            avatarImageView.layer.borderWidth = 2.0
            avatarImageView.layer.borderColor = UIColor.white.cgColor
            avatarImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var folowingCountLabel: UILabel!
    @IBOutlet weak var folowingTitleLabel: UILabel!
    
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followersTitleLabel: UILabel!
    
    @IBOutlet weak var heartsCountLabel: UILabel!
    @IBOutlet weak var heartsTitleLabel: UILabel!
    
    @IBOutlet weak var currentDetailsLabel: UILabel!
    
    var coordinator: AppCoordinator?
    
    var profile: Profile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(reload), for: .valueChanged)
    }
    
    @objc private func reload() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.scrollView.refreshControl?.endRefreshing()
        }
    }

}
