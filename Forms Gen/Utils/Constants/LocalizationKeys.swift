import Foundation

enum LocalizationKeys {
    enum Common {
        static let ok = "ok"
        static let cancel = "cancel"
        static let error = "error"
        static let success = "success"
    }
    
    enum Home {
        static let title = "all_forms"
        static let searchPlaceholder = "search_forms"
        static let dateModified = "date_modified"
        static let recentForms = "recent_forms"
        static let sharedForms = "shared_forms"
        static let trashedForms = "trashed_forms"
    }
    
    enum Auth {
        static let login = "login"
        static let signup = "signup"
        static let email = "email"
        static let password = "password"
        static let forgotPassword = "forgot_password"
    }
    
    // Keys for CreateFormViewController
    static let createGoogleFormTitle = "create_google_form"
    
    // Keys for QuestionCell
    static let enterYourAnswer = "enter_your_answer"
    
    // Keys for QuestionTypeSelectionViewController
    static let selectQuestionType = "select_question_type"
    
    // Keys for Question Types
    static let shortAnswer = "short_answer"
    static let multipleChoice = "multiple_choice"
    static let checkbox = "checkbox"
    static let paragraph = "paragraph"
} 