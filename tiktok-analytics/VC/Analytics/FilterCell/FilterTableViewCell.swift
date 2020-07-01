import UIKit

class FilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var borderView: UIView! {
        didSet {
            borderView.layer.cornerRadius = borderView.bounds.height / 2
            borderView.layer.borderWidth = 0.6
            borderView.layer.borderColor = UIColor(hex: 0xAAAAAA).cgColor
            borderView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var dotView: UIView! {
        didSet {
            dotView.layer.cornerRadius = dotView.bounds.height / 2.0
            dotView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        dotView.isHidden = !selected
        borderView.layer.borderColor = selected ? UIColor(hex: 0x2D9AFF).cgColor : UIColor(hex: 0xAAAAAA).cgColor
    }
}
