import UIKit

class HeaderImageCell: UITableViewCell {
    
    @IBOutlet weak var headerImageView: UIImageView! // Connect this to your UIImageView in the storyboard

    override func awakeFromNib() {
        super.awakeFromNib()
        // Additional setup if needed
    }
    
    func configure(with image: UIImage?) {
        if let image {
            headerImageView.isHidden = false
            headerImageView.image = image
        } else {
            headerImageView.isHidden = true
        }
    }
} 
