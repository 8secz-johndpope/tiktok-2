import UIKit

class ProfileViewController: UIViewController, BarButtonItemConfigurable {
    
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
        
        let control = UIRefreshControl()
        control.tintColor = .white
        control.addTarget(self, action: #selector(reload), for: .valueChanged)
        scrollView.refreshControl = control
        
        refreshRightBarButtonItem()
        refreshLeftBarButtonItem()
    }
    
    var rightBarButtonItemType: RightBarButtonItem {
        return .exit
    }
    
    var leftBarButtonItemType: LeftBarButtonItem {
        return .none
    }
    
    override func actionExit() {
        coordinator?.pop()
    }
    
    @objc private func reload() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.scrollView.refreshControl?.endRefreshing()
        }
    }
    
    @IBAction func actionShowVideos() {
        coordinator?.showVideos()
    }
    
}
