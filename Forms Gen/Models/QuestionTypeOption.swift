import UIKit

struct QuestionTypeOption {
    let type: QuestionType
    let image: UIImage
}

enum QuestionType: String, CaseIterable {
    case shortAnswer = "short_answer"
    case multipleChoice = "multiple_choice"
    case checkbox = "checkbox"
    case paragraph = "paragraph"
    
    var image: UIImage {
        switch self {
        case .shortAnswer:
            return UIImage(named: "ShortAnswer")!
        case .multipleChoice:
            return UIImage(named: "MultipleChoice")!
        case .checkbox:
            return UIImage(named: "Checkbox")!
        case .paragraph:
            return UIImage(named: "Paragraph")!
        }
    }
    
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "Question type: \(self.rawValue)")
    }
} 
