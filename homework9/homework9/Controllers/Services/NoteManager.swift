import Foundation

enum UserDefaultKeys {
    static let notes = "notes"
}

class NoteManager {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let userDefaults = UserDefaults.standard

    func create(note: Note) {
        if let objectByKey = userDefaults.object(forKey: UserDefaultKeys.notes) as? Data {
            guard var notes = try? decoder.decode([Note].self, from: objectByKey) else { return }

            notes.append(note)
            notes.sort{$0.date > $1.date}

            let jsonData = try! encoder.encode(notes)
            userDefaults.set(jsonData, forKey: UserDefaultKeys.notes)
        }
        else {
            let jsonData = try! encoder.encode([note])
            userDefaults.set(jsonData, forKey: UserDefaultKeys.notes)

        }
    }

    func update(note: Note, index: Int) {
        if let objectByKey = userDefaults.object(forKey: UserDefaultKeys.notes) as? Data {
            guard var notes = try? decoder.decode([Note].self, from: objectByKey) else { return }

            notes[index] = note

            let jsonData = try! encoder.encode(notes)
            userDefaults.set(jsonData, forKey: UserDefaultKeys.notes)
        }
    }

    func set(notes: [Note]) {
        let jsonData = try! encoder.encode(notes)
        UserDefaults.standard.set(jsonData, forKey: UserDefaultKeys.notes)
    }
}
