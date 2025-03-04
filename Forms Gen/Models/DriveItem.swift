import Foundation
import GoogleAPIClientForREST

enum DriveItemType {
    case folder
    case file
}

struct DriveItem {
    let id: String
    let name: String
    let modifiedDate: Date
    let isShared: Bool
    let thumbnailLink: String?
    let type: DriveItemType
    
    init(from driveFile: GTLRDrive_File) {
        self.id = driveFile.identifier ?? ""
        self.name = driveFile.name ?? ""
        self.modifiedDate = driveFile.modifiedTime?.date ?? Date()
        self.isShared = !(driveFile.permissions?.isEmpty ?? true)
        self.thumbnailLink = driveFile.thumbnailLink
        self.type = driveFile.mimeType == "application/vnd.google-apps.folder" ? .folder : .file
    }
    
    var formattedModifiedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: modifiedDate)
    }
} 