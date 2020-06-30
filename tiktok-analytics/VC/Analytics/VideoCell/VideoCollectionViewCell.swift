import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 21.0
        layer.masksToBounds = true
    }
}
