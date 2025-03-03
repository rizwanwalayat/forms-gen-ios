import Foundation
import GoogleAPIClientForREST

struct Form {
    let id: String
    let name: String
    let modifiedDate: Date
    let isShared: Bool
    let thumbnailLink: String?
    let isFolder: Bool
    
    init(from driveFile: GTLRDrive_File) {
        self.id = driveFile.identifier ?? ""
        self.name = driveFile.name ?? ""
        self.modifiedDate = driveFile.modifiedTime?.date ?? Date()
        self.isShared = !(driveFile.permissions?.isEmpty ?? true)
        self.thumbnailLink = driveFile.thumbnailLink
        self.isFolder = driveFile.mimeType == "application/vnd.google-apps.folder"
        print("File ID: \(self.id), Name: \(self.name), MIME Type: \(driveFile.mimeType ?? "Unknown"), Is Folder: \(self.isFolder)")
    }
    
    var formattedModifiedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: modifiedDate)
    }
} 
