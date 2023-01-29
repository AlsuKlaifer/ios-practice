class DataManagerApp {
    
    static let shared = DataManagerApp()
    
    let names = [
    "Folder", "Calendar", "Telegram", "Books", "Notes", "Phone", "Weather"
    ]
    
    let images = [
        "folder",
        "calendar",
        "paperplane",
        "book",
        "square.text.square",
        "phone",
        "cloud.sun"
    ]
    
    let descriptions = [
    "",
    "",
    "Write to friends",
    "Unread books left: 6",
    "",
    "",
    ""
    ]
    
    private init() {}
}
