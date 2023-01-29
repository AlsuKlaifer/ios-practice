import UIKit

class CustomTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private let nameLabel: UILabel = .init()
    private let ageLabel: UILabel = .init()
    private let disguiseLabel: UILabel = .init()
    private let colorView: UIView = .init()
    private let roleLabel: UILabel = .init()
    
    func set(fixik: Fixik){
        colorView.backgroundColor = fixik.color
        nameLabel.text = fixik.name
        ageLabel.text = "Age: \(fixik.age)"
        disguiseLabel.text = "Disguise: \(fixik.disguise)"
        disguiseLabel.numberOfLines = 0
        roleLabel.text = "Role in cartoon: \(fixik.role)"
    }
    
    private func setup() {
        nameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        ageLabel.font = .systemFont(ofSize: 17, weight: .regular)
        disguiseLabel.font = .systemFont(ofSize: 17, weight: .regular)
        roleLabel.font = .systemFont(ofSize: 17, weight: .regular)
        let colorStack = UIStackView(arrangedSubviews: [colorView])
        let stackView = UIStackView(arrangedSubviews: [nameLabel, ageLabel, disguiseLabel, roleLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        
        contentView.addSubview(stackView)
        contentView.addSubview(colorStack)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        colorStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            colorStack.widthAnchor.constraint(equalToConstant: 13),
            colorStack.heightAnchor.constraint(equalToConstant: 130),
            colorStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            colorStack.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 10),
            colorStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            colorStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
