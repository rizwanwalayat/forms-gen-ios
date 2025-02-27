import Foundation
import GoogleAPIClientForREST

struct Form {
    let id: String
    let name: String
    let modifiedDate: Date
    let isShared: Bool
    
    init(from driveFile: GTLRDrive_File) {
        self.id = driveFile.identifier ?? ""
        self.name = driveFile.name ?? ""
        self.modifiedDate = driveFile.modifiedTime?.date ?? Date()
        self.isShared = !(driveFile.permissions?.isEmpty ?? true)
    }
} 
