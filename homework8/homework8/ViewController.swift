import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    private func headerCellSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), repeatingSubitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    private func catsCellSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)), repeatingSubitem: item, count: 2)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }

    private func memesCellSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(250)))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(250)), repeatingSubitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        let spacing: CGFloat = 20
        section.interGroupSpacing = spacing
        section.contentInsets = .init(top: 20, leading: 0, bottom: 0, trailing: 0)
        return section
    }

    private lazy var collectionView: UICollectionView = {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(
            sectionProvider: { [weak self] section, environment in
                guard let self else {fatalError("Self is nil")}
                guard let section = Section(rawValue: section) else {fatalError("Section \(section) does not exist")}
                switch section {
                case .headerCat:
                    return self.headerCellSection()
                case .cat:
                    return self.catsCellSection()
                case .headerMeme:
                    return self.headerCellSection()
                case .meme:
                    return self.memesCellSection()                }
            },
            configuration: configuration
        )
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    private func setup() {
        view.backgroundColor = .systemBackground

        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        collectionView.register(CustomCatCell.self, forCellWithReuseIdentifier: "\(Section.cat)")
        collectionView.register(CustomMemeCell.self, forCellWithReuseIdentifier: "\(Section.meme)")
        collectionView.register(CustomHeaderCell.self, forCellWithReuseIdentifier: "\(Section.headerCat)")
        collectionView.register(CustomHeaderCell.self, forCellWithReuseIdentifier: "\(Section.headerMeme)")
        collectionView.dataSource = self
    }

    enum Section: Int, CaseIterable {
        case headerCat
        case cat
        case headerMeme
        case meme
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .headerCat: return 1
        case .cat: return cats.count
        case .headerMeme: return 1
        case .meme: return memes.count
        case nil: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let section = Section(rawValue: indexPath.section) else {fatalError()}
        
        switch section {
        case .cat:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(section)", for: indexPath) as? CustomCatCell else {fatalError("Could not deque cell of \(section)")}
            let image = cats[indexPath.row]
            cell.set(imageUrl: image.url)
            return cell
            
        case .meme:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(section)", for: indexPath) as? CustomMemeCell else {fatalError("Could not deque cell of \(section)")}
            let image = memes[indexPath.row]
            cell.set(text: image.text, imageUrl: image.url)
            return cell
            
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(section)", for: indexPath) as? CustomHeaderCell else {fatalError("Could not deque cell of \(section)")}
            var header: String
            if (section == .headerCat) {header = headers[0]} else {header = headers[1]}
            cell.set(text: header)
            cell.contentView.backgroundColor = .systemGray5
            return cell
        }
    }
    
    
    private struct Meme{
        let text: String
        let url: URL
    }
    
    private struct Cat{
        let url: URL
    }
    
    private let headers: [String] = [
        "Cats",
        "Memes"
    ]
    
    private let memes: [Meme] = [
        .init(text: "Это база", url: URL(string: "https://sun9-77.userapi.com/impg/tzMRKz-eavp7tJjk-Zk6XJv0KDG-Xi51W3x86w/x8D-Kt5gDso.jpg?size=1280x950&quality=95&sign=bd402d532e8d29c8e64c6df219ff6e91&type=album")!),
        .init(text: "Based", url: URL(string: "https://sun9-79.userapi.com/impg/n16kgmIo-uI6Br1P-FbMTFuhBiJrusgMmLuG2Q/rLjzEoQluBs.jpg?size=1280x769&quality=95&sign=3de7a18a032d19189c263f2e1e4ef42c&type=album")!),
        .init(text: "Это самая такая база", url: URL(string: "https://sun9-44.userapi.com/impg/D6xOm_4cdgxSsBgkMENf0Wm4RFj4AFkcrBQTpw/YnkKyeyZoZ0.jpg?size=1235x825&quality=95&sign=fe3f7f0efe48d107eda2ce725aa4614b&type=album")!),
        .init(text: "Это основа, это так сказать база", url: URL(string: "https://sun9-14.userapi.com/impg/Kh9BY1ERpmYFHmpLYuLOAKCwGN2NCZalWUSHUQ/ytEhTDigNBE.jpg?size=522x348&quality=95&sign=d25e4443e1c2c991abf1359568fae664&type=album")!),
        .init(text: "Это база", url: URL(string: "https://sun9-76.userapi.com/impg/shHu2ehIdl-brvvOoHXqh-LLGILFM497SgPTew/Zr0eJ2MFdp0.jpg?size=1280x948&quality=95&sign=49b428ba48147d57c01a11010234c3e1&type=album")!),
        .init(text: "Проще говоря, база", url: URL(string: "https://sun9-21.userapi.com/impg/Y_BOOt_WFnzFQ21UDXlSNF0m8GrbiX-MBLgIFQ/q3Uo6zHJMVI.jpg?size=602x401&quality=95&sign=aaa9af57be92030d1b7835f085e08b6d&type=album")!),
        .init(text: "Это доброе утро", url: URL(string: "https://sun9-65.userapi.com/impg/luORputdlLdsA7TWHKGw76nK8oL7G086-5XIxg/rosE9H81xYQ.jpg?size=828x552&quality=95&sign=8f91044266c5653293ede3d2bd19a9d8&type=album")!),
        .init(text: "Это костюм на хэллоуин", url: URL(string: "https://sun9-86.userapi.com/impg/RZcpiheVQSEZ5fT-_8fc0V9haD_FDCy5cezo_w/lpSxw1v6UCI.jpg?size=414x276&quality=95&sign=c72862ddbad6afcb4614067e227ab4f1&type=album")!),
        .init(text: "Программирование - это танец", url: URL(string: "https://sun9-68.userapi.com/impg/lRif6wO23lgIdM7oBvmElpm08AwJ5IrbM691mA/1prblQ9WwWI.jpg?size=734x489&quality=95&sign=5bafbf398172ba4007175e3f7ed52076&type=album")!),
        .init(text: "Do you know this person?", url: URL(string: "https://sun9-26.userapi.com/impg/mK9aXqV-sW51UXoRJDMloWQ8iVPx7w9gf6VTFA/0YkVDRtF_Dc.jpg?size=717x478&quality=95&sign=a7e3547ad172d72c0f3201b50f6c3804&type=album")!),
        .init(text: "Получили фулл за домашку", url: URL(string: "https://sun9-78.userapi.com/impg/OwMn7EskyuRtUEjieAqgl9aZ60ltoTF6ByK6oA/IOJltmO7y1M.jpg?size=604x403&quality=95&sign=3fef2fe84f2eeab4cbb1a642a38a4c12&type=album")!)
    ]
    
    private let cats: [Cat] = [
        .init(url: URL(string: "https://pic.rutubelist.ru/user/66/07/660781fbc2ad90a85e7f9b6f02db4e69.jpg")!),
        .init(url: URL(string: "https://cdn.trinixy.ru/pics6/20220719/229538_3_trinixy_ru.jpg")!),
        .init(url: URL(string: "https://media.2x2tv.ru/content/images/2021/12/bender.jpg")!),
        .init(url: URL(string: "https://www.meme-arsenal.com/memes/fe15984c631bbc24c0b6beb140dc621b.jpg")!),
        .init(url: URL(string: "https://icdn.lenta.ru/images/2020/09/30/13/20200930130228617/pwa_vertical_1280_8d172d6dae702e03017c045d5142ee5e.jpg")!),
        .init(url: URL(string: "https://kartinkof.club/uploads/posts/2022-03/1648329592_2-kartinkof-club-p-kot-s-ulibkoi-mem-2.png")!),
        .init(url: URL(string: "https://i.pinimg.com/736x/77/a9/96/77a996d770a002e945342816ce281286.jpg")!),
        .init(url: URL(string: "https://www.meme-arsenal.com/memes/b41570f4eb67832429c7f4ff7f9ac67c.jpg")!),
        .init(url: URL(string: "https://cs12.pikabu.ru/post_img/2019/04/15/9/1555339015135017638.jpg")!),
        .init(url: URL(string: "https://www.meme-arsenal.com/memes/e77529bc5454bebb776dbefd127f68f5.jpg")!),
        .init(url: URL(string: "https://www.anekdot.ru/i/caricatures/normal/21/10/31/1635671993.jpg")!),
        .init(url: URL(string: "https://memepedia.ru/wp-content/uploads/2020/12/pop-cat-2.jpg")!)
    ]
}
