import UIKit

class QuestionCell: UITableViewCell {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var optionsStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Additional setup if needed
        answerTextField.isHidden = true
        optionsStackView.isHidden = true
    }
    
    func configure(with question: Question) {
        questionLabel.text = question.questionText
        
        // Clear previous options
        optionsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        switch question.type {
        case .shortAnswer:
            answerTextField.isHidden = false
            optionsStackView.isHidden = true
        case .paragraph:
            answerTextField.isHidden = false
            optionsStackView.isHidden = true
            // Localize the placeholder for paragraph input
            answerTextField.placeholder = NSLocalizedString(LocalizationKeys.enterYourAnswer, comment: "Placeholder for paragraph input")
        case .multipleChoice:
            answerTextField.isHidden = true
            optionsStackView.isHidden = false
            setupOptions(for: question)
        case .checkbox:
            answerTextField.isHidden = true
            optionsStackView.isHidden = false
            setupOptions(for: question)
        }
    }
    
    private func setupOptions(for question: Question) {
        for option in question.options {
            let button = UIButton(type: .system)
            button.setTitle(option, for: .normal)
            button.addTarget(self, action: #selector(optionSelected(_:)), for: .touchUpInside)
            optionsStackView.addArrangedSubview(button)
        }
    }
    
    @objc private func optionSelected(_ sender: UIButton) {
        // Handle option selection
        print("Selected option: \(sender.title(for: .normal) ?? "")")
        // You can add additional logic here to handle the selected option
    }
} 