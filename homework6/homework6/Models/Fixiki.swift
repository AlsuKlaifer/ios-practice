import UIKit
struct Fixik{
    let name: String
    let age: Int
    let color: UIColor
    let disguise: String
    let role: String
    
    static func getFixikList() -> [Fixik] {
        let fixiki: [Fixik] = [
       
            Fixik(name: "Simka", age: 9, color: .orange, disguise: "hex bolt with aiming and press washer", role: "main"),
            Fixik(name: "Nolik", age: 5, color: .blue, disguise: "pan head screw with slot", role: "main"),
            Fixik(name: "Papus", age: 35, color: .green, disguise: "pointed bolt with hex head and hex slot", role: "father"),
            Fixik(name: "Masya", age: 33, color: .systemPink, disguise: "round head screw with slot", role: "mother"),
            Fixik(name: "Dedus", age: 150, color: .brown, disguise: "three-handed wing screw", role: "professor"),
            Fixik(name: "Fire", age: 9, color: .red, disguise: "hex bolt with hex socket", role: "studend"),
            Fixik(name: "Igrek", age: 10, color: .purple, disguise: "led bolt with thread and wrench", role: "student"),
            Fixik(name: "Shpulya", age: 11, color: .yellow, disguise: "German type wing screw", role: "studend"),
            Fixik(name: "Verta", age: 11, color: .green, disguise: "semicircular head screw with golden press washer", role: "studend"),
            Fixik(name: "Alt", age: 11, color: .blue, disguise: "screw with marks on the handles", role: "studend"),
            Fixik(name: "Mega", age: 5, color: .red, disguise: "star screw", role: "child")

        ]
        
        return fixiki
    }
}
