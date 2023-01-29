import UIKit

struct Note: Codable {
    var type: String
    var title: String
    var content: String?
    var imageName: String?
    let date: String
    
    init(type: String, title: String, content: String?, date: String) {
        self.type = type
        self.title = title
        self.content = content
        self.date = date
    }
    
    init(type: String, title: String, imageName: String?, date: String) {
        self.type = type
        self.title = title
        self.imageName = imageName
        self.date = date
    }
}

enum NoteType: String {
    case textNote = "textNote"
    case photoNote = "photoNote"
}
