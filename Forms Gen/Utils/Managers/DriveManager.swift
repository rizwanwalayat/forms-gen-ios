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
    func fetchForms(completion: @escaping ([GTLRDrive_File]?, Error?) -> Void) {
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
                let files = fileList.files ?? []
                for file in files {
                    print("Fetched file - ID: \(file.identifier ?? ""), Name: \(file.name ?? ""), MIME Type: \(file.mimeType ?? "Unknown")")
                }
                completion(files, nil)
            }
        }
    }
} 
