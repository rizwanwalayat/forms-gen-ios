import UIKit

class FormCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sharedIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Set fonts immediately when cell is loaded from storyboard
        titleLabel.font = .inter(.medium, size: 16)
        dateLabel.font = .inter(.regular, size: 14)
    }
    
    func configure(with form: Form) {
        titleLabel.text = form.name
        if #available(iOS 15.0, *) {
            dateLabel.text = form.modifiedDate.formatted()
        } else {
            dateLabel.text = "\(form.modifiedDate)"
        }
        sharedIcon.isHidden = !form.isShared
    }
} 
