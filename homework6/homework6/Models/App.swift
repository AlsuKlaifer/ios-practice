struct App{
    
    let name: String
    let image: String
    let description: String
    
    static func getAppList() -> [App] {
        var apps: [App] = []
        let names = DataManagerApp.shared.names
        let images = DataManagerApp.shared.images
        let descriptions = DataManagerApp.shared.descriptions
        
        for index in 0..<7 {
            let app = App(name: names[index], image: images[index], description: descriptions[index])
            apps.append(app)
        }
        
        return apps
    }
}
