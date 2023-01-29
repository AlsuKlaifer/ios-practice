import UIKit
import PhotosUI

class PhotoNoteController: UIViewController, PHPickerViewControllerDelegate {
    
    private let noteManager = NoteManager()
    var noteService = NoteService()

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
    
    private let imageNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Image name"
        textField.font = .systemFont(ofSize: 20)
        textField.backgroundColor = .systemBackground
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 10
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, 0))
        textField.leftView = paddingView
        textField.leftViewMode = UITextField.ViewMode.always;
        return textField
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup(){
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonAction(sender:))),
            UIBarButtonItem(title: "Photo", style: .plain, target: self, action: #selector(AddPhotoButtonAction(sender:)))
            ]
                                             
        if let note {
            titleTextField.text = note.title
            imageNameTextField.text = note.imageName
            try? imageView.image = noteService.getImage(imageName: (note.imageName)!)
        }
        
        view.backgroundColor = .systemGray5
        
        let stackView = UIStackView(arrangedSubviews: [ titleTextField, imageNameTextField, imageView])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(equalToConstant: 40),
            imageNameTextField.heightAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    @objc func saveButtonAction(sender: UIBarButtonItem!){
        
        if imageNameTextField.text == "" {
            let alert = UIAlertController(title: "Error", message: "Image name must be set", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")}))
            self.present(alert, animated: true, completion: nil)
        }
        
        if imageView.image != nil {

            guard let title = titleTextField.text, let name = imageNameTextField.text else { return }

            let image = imageView.image!

            if note == nil {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM d, h:mm:ss a"
                let creationDate = "\(dateFormatter.string(from: NSDate.now))"
                let imageName = UUID().uuidString
                note = Note(type: NoteType.photoNote.rawValue, title: title, imageName: imageName, date: creationDate)
                noteManager.create(note: note!)
            }
            else {
                note!.title = title
                note!.imageName = name
                noteManager.update(note: note!, index: index!)
            }

            try? noteService.save(image: image, imageName: (note!.imageName)!)

            navigationController?.popViewController(animated: true)

        } else {
            let alert = UIAlertController(title: "Error", message: "Add photo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default))
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    @objc func AddPhotoButtonAction(sender: UIBarButtonItem!) {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        let phPicker = PHPickerViewController(configuration: configuration)
        phPicker.delegate = self
        present(phPicker, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        results.forEach { result in
            print("Asset identifier: \(result.assetIdentifier ?? "none")")
            result.itemProvider.loadObject(ofClass: UIImage.self) { [self] reading, error in
                if let error {
                    print("Got error loading image: \(error)")
                } else if let image = reading as? UIImage {
                    DispatchQueue.main.async { [self] in
                        imageView.image = image
                    }
                }
            }
        }
    }
}
