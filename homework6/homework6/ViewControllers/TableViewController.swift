import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    private let apps = App.getAppList()
    private let fixiki = Fixik.getFixikList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private let tableView: UITableView = .init(frame: .zero, style: .insetGrouped)

    private func setup() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CellIdentifier.fixik.rawValue)
        tableView.dataSource = self
        tableView.reloadData()
        tableView.delegate = self
    }
    
    enum CellIdentifier: String {
        case fixik
        case app
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: UITableViewCell
            if let dequeueCell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.app.rawValue){
                cell = dequeueCell
            } else {
                cell = UITableViewCell(style: .default, reuseIdentifier: CellIdentifier.app.rawValue)
            }
            
            let app = apps[indexPath.row]
            var configuration = UIListContentConfiguration.valueCell()
            configuration.text = app.name
            configuration.image = UIImage(systemName: app.image)
            configuration.secondaryText = app.description
            cell.contentConfiguration = configuration
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.fixik.rawValue, for: indexPath) as? CustomTableViewCell else{
                fatalError("Could not deque cell of type \(CustomTableViewCell.self)")
            }
            
            let fixik = fixiki[indexPath.row]
            cell.set(fixik: fixik)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return apps.count
        }
        else {
            return fixiki.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let stackview = UIStackView()
        stackview.backgroundColor = .clear
        let label = UILabel()
        label.font = .monospacedDigitSystemFont(ofSize: 20, weight: .semibold)
        if section == 0 {
            label.text = "Apps"
            label.textColor = .systemBlue
        }
        else{
            label.text = "Fixiki"
            label.textColor = .black
        }
            stackview.addArrangedSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: stackview.leadingAnchor, constant: 30),
                label.bottomAnchor.constraint(equalTo: stackview.topAnchor, constant: 50)
                ])
            
            return stackview
        }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        } else {
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 50
        }
        else{
            return 130
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
        tableView.deselectRow(at: indexPath, animated: true)
            let fix = fixiki[indexPath.row]
            print("Name: \(fix.name), age: \(fix.age), color: \(fix.color.accessibilityName), disguise: \(fix.disguise), role in cartoon: \(fix.role)")
        }
    }
}
