import UIKit

class FormCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fileIcon: UIImageView!

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
        // Load the thumbnail image
        if let thumbnailURL = form.thumbnailLink, let url = URL(string: thumbnailURL) {
            // Use a library like SDWebImage or URLSession to load the image asynchronously
            // Example using URLSession:
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.fileIcon.image = image
                    }
                }
            }.resume()
        } else {
            fileIcon.image = nil // Clear the image if no thumbnail
        }
    }
}
