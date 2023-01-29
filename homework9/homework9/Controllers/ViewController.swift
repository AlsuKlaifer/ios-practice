import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let noteManager = NoteManager()
    
    var notes = [Note]()
    
    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var configuration = UIListContentConfiguration.cell()
        configuration.text = "\(notes[indexPath.row].title)"
        configuration.secondaryText = "\(notes[indexPath.row].date)"
        cell.contentConfiguration = configuration
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = notes[indexPath.row].type
        
        if (type == NoteType.textNote.rawValue) {
            let vc = NoteController()
            vc.note = notes[indexPath.row]
            vc.index = indexPath.row
            show(vc, sender: self)
        }
        
        else if (type == NoteType.photoNote.rawValue) {
            let vc = PhotoNoteController()
            vc.note = notes[indexPath.row]
            vc.index = indexPath.row
            show(vc, sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [self]
            (_, _, completed) in
            completed(true)
            notes.remove(at: indexPath.row)
            noteManager.set(notes: notes)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notes"
        setup()
    }

    func setup(){
        navigationItem.title = "Notes"
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(AddNoteButtonAction(sender:))),
            UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(AddPhotoNoteButtonAction(sender:)))
            ]
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = self
        tableView.reloadData()
        tableView.delegate = self
    }
    
    @objc func AddNoteButtonAction(sender: UIBarButtonItem!){
        let vc = NoteController()
        show(vc, sender: self)
    }
                            
    @objc func AddPhotoNoteButtonAction(sender: UIBarButtonItem!){
        let vc = PhotoNoteController()
        show(vc, sender: self)
    }
    
    func loadData() {
        if let res = UserDefaults.standard.object(forKey: UserDefaultKeys.notes) as? Data {
            let decoder = JSONDecoder()
            guard let note = try? decoder.decode([Note].self, from: res) else { return }
            notes = note
            notes.sort(by: {$0.date > $1.date})
        }
    }
}
