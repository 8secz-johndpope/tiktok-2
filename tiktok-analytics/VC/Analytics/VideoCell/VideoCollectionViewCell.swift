import UIKit
import Kingfisher

class VideoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var sharesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.cornerRadius = 21.0
        contentView.layer.masksToBounds = true
    }
    
    func setup(withVideo video: Video) {
        imageView.kf.setImage(with: video.cover)
        viewsLabel.text = video.plays.formatted
        likesLabel.text = video.likes.formatted
        commentsLabel.text = video.comments.formatted
        sharesLabel.text = video.shares.formatted
    }
}
