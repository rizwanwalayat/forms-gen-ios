import GoogleSignIn
import GoogleAPIClientForREST
import GTMSessionFetcher
//import GTMAppAuth

class DriveManager {
    static let shared = DriveManager()
    private let service = GTLRDriveService()
    
    private init() {
        service.shouldFetchNextPages = true
        service.isRetryEnabled = true
    }
    
    func configure() {
        if let user = GIDSignIn.sharedInstance.currentUser {
            service.authorizer = user.fetcherAuthorizer
        }
    }
    func fetchForms(completion: @escaping ([DriveItem]?, Error?) -> Void) {
        let query = GTLRDriveQuery_FilesList.query()
        // Search for Google Forms and folders
        query.q = "mimeType='application/vnd.google-apps.form' or mimeType='application/vnd.google-apps.folder'"
        query.fields = "files(id,name,mimeType,modifiedTime,permissions,thumbnailLink)"
        
        service.executeQuery(query) { (ticket, result, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            if let fileList = result as? GTLRDrive_FileList {
                let items = fileList.files?.compactMap { DriveItem(from: $0) } ?? []
                completion(items, nil)
            }
        }
    }
    
    func createGoogleForm(with data: [String: Any], completion: @escaping (Bool, Error?) -> Void) {
        // Prepare the form data
        let formData: [String: Any] = [
            "title": data["title"] as? String ?? "",
            "description": data["description"] as? String ?? "",
            "items": (data["questions"] as? [[String: Any]])?.map { question in
                return [
                    "questionItem": [
                        "question": question["question"] as? String ?? "",
                        "questionType": question["type"] as? String ?? "",
                        "options": question["options"] as? [String] ?? []
                    ]
                ]
            } ?? []
        ]
        
        // Create the request
        let query = GTLRDriveQuery_FilesCreate.query(withObject: GTLRDrive_File(), uploadParameters: nil)
        query.fields = "id,name"
        
        // Set the request body
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: formData, options: [])
            let uploadParameters = GTLRUploadParameters(data: jsonData, mimeType: "application/json")
            query.uploadParameters = uploadParameters
        } catch {
            completion(false, error)
            return
        }
        
        // Execute the query
        service.executeQuery(query) { (ticket, result, error) in
            if let error = error {
                completion(false, error)
                return
            }
            // Handle success
            completion(true, nil)
        }
    }
} 
