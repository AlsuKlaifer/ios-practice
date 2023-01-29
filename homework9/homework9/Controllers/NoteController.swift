import UIKit

class NoteController : UIViewController {

    private let noteManager = NoteManager()
    
    var note: Note?
    var index: Int?
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.font = .systemFont(ofSize: 20)
        textField.backgroundColor = .systemBackground
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 10
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, 0))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always;
        return textField
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemBackground
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 10
        textView.font = .systemFont(ofSize: 16)
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save", style: .plain, target: self, action: #selector(buttonAction(sender:)))
        
        if let note {
            titleTextField.text = note.title
            contentTextView.text = note.content
        }
        
        view.backgroundColor = .systemGray5
        
        let stackView = UIStackView(arrangedSubviews: [ titleTextField, contentTextView])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            contentTextView.heightAnchor.constraint(equalToConstant: 240),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func buttonAction(sender: UIBarButtonItem!){
        guard let title = titleTextField.text, let content = contentTextView.text else { return }
        
        if title == ""{
            let alert = UIAlertController(title: "Error", message: "Title must be set", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")}))
            self.present(alert, animated: true, completion: nil)
        }
        
        if note == nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, h:mm:ss a"
            let creationDate = "\(dateFormatter.string(from: NSDate.now))"
            
            let note = Note(type: NoteType.textNote.rawValue, title: title, content: content, date: creationDate)
            print("in noteController \(note)")
            noteManager.create(note: note)

        }
        else{
            note?.title = title
            note?.content = content
            noteManager.update(note: note!, index: index!)
        }
        
        navigationController?.popViewController(animated: true)
    }
}
