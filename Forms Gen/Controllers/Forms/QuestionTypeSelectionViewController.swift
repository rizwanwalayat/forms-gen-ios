import UIKit

protocol QuestionTypeSelectionDelegate: AnyObject {
    func didSelectQuestionType(_ type: QuestionType)
}

class QuestionTypeSelectionViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: QuestionTypeSelectionDelegate?
    
    private let questionTypes: [QuestionTypeOption] = {
        return QuestionType.allCases.map { QuestionTypeOption(type: $0, image: $0.image) }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Calculate the height based on the number of question types
        let rowHeight: CGFloat = 44.0 // Standard row height
        let totalHeight = CGFloat(questionTypes.count) * rowHeight
        preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: totalHeight) // Full screen width
        
        // Force layout to ensure the table view calculates its size correctly
        tableView.layoutIfNeeded()
    }
    
    private func setupUI() {
        titleLabel.text = NSLocalizedString(LocalizationKeys.selectQuestionType, comment: "Title for selecting question type")
        titleLabel.font = .inter(.medium, size: 18)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set row height to automatic dimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0 // Set an estimated row height
    }
}

// MARK: - UITableViewDataSource
extension QuestionTypeSelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionTypeCell", for: indexPath)
        let questionTypeOption = questionTypes[indexPath.row]
        
        cell.textLabel?.text = questionTypeOption.type.localizedString
        cell.imageView?.image = questionTypeOption.image
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedType = questionTypes[indexPath.row].type
        delegate?.didSelectQuestionType(selectedType)
        navigationController?.popViewController(animated: true)
    }
} 
