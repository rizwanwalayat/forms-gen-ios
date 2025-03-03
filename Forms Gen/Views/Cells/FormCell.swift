import UIKit

class FormCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var fileIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Set fonts immediately when cell is loaded from storyboard
        titleLabel.font = .inter(.medium, size: 16)
        dateLabel.font = .inter(.regular, size: 12)
    }
    func configure(with form: Form) {
        titleLabel.text = form.name
        dateLabel.text = form.formattedModifiedDate
        
        if form.isFolder {
            fileIcon.image = UIImage(named: "Folder")
        } else {
            // Load the thumbnail image
            if let thumbnailURL = form.thumbnailLink, let url = URL(string: thumbnailURL) {
                URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.fileIcon.image = image
                        }
                    }
                }.resume()
            } else {
                fileIcon.image = UIImage(systemName: "doc.fill")
            }
        }
    }
}
