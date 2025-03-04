import UIKit

struct Question {
    var type: QuestionType
    var questionText: String
    var options: [String] // For multiple choice and checkbox
}

class CreateFormViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var questions: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        // Localize the title
        title = NSLocalizedString(LocalizationKeys.createGoogleFormTitle, comment: "Title for creating a Google Form")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func addQuestionButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
        if let questionTypeSelectionVC = storyboard.instantiateViewController(withIdentifier: "QuestionTypeSelectionViewController") as? QuestionTypeSelectionViewController {
            questionTypeSelectionVC.delegate = self
            
            // Set the modal presentation style to pageSheet for bottom sheet presentation
            questionTypeSelectionVC.modalPresentationStyle = .pageSheet
            
            // Configure the sheet presentation controller
            if let sheetController = questionTypeSelectionVC.sheetPresentationController {
                sheetController.detents = [.medium(), .large()] // Set the detents for the sheet
                sheetController.prefersGrabberVisible = true // Show the grabber for better UX
            }
            
            present(questionTypeSelectionVC, animated: true, completion: nil)
        }
    }
    
    private func addQuestion(of type: QuestionType) {
        let newQuestion = Question(type: type, questionText: "", options: [])
        questions.append(newQuestion)
        tableView.reloadData()
    }
    
    @IBAction func submitFormButtonTapped(_ sender: UIButton) {
        // Prepare the data to send
        let formData: [String: Any] = [
            "title": questions.first?.questionText ?? "",
            "description": questions.count > 1 ? questions[1].questionText : "",
            "questions": questions.map { question in
                return [
                    "question": question.questionText,
                    "type": question.type.rawValue,
                    "options": question.options
                ]
            }
        ]
        
        // Call the createGoogleForm method
        DriveManager.shared.createGoogleForm(with: formData) { success, error in
            if success {
                print("Form created successfully!")
                // Optionally navigate back or show a success message
            } else {
                print("Error creating form: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension CreateFormViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // One section for header, title/description, and questions
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count + 2 // +1 for header image cell and +1 for title/description cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // Header image cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderImageCell", for: indexPath) as! HeaderImageCell
            cell.configure(with: UIImage(named: "your_image_name")) // Replace with your image name
            return cell
        } else if indexPath.row == 1 {
            // Title and Description cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleDescriptionCell", for: indexPath)
            cell.textLabel?.text = "Form Title"
            cell.detailTextLabel?.text = questions.first?.questionText ?? "Enter title"
            return cell
        } else {
            // Question cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath) as! QuestionCell
            let question = questions[indexPath.row - 2] // Adjust index for questions
            cell.configure(with: question)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle cell selection if needed
    }
}

// MARK: - QuestionTypeSelectionDelegate
extension CreateFormViewController: QuestionTypeSelectionDelegate {
    func didSelectQuestionType(_ type: QuestionType) {
        addQuestion(of: type)
    }
} 
