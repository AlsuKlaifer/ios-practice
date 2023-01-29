import UIKit

class CustomCatCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        return image
    }()
    
    func set(imageUrl: URL) {
        loadImage(url: imageUrl)
    }
    
    private var dataTask: URLSessionDataTask?

    private func loadImage(url: URL) {
        imageView.image = nil
        dataTask?.cancel()
        let urlRequest = URLRequest( url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        dataTask = URLSession.shared.dataTask(with: urlRequest) { [imageView] data, _, _ in
            guard let data else {
                print("could not load image")
                return
            }

            let image = UIImage(data: data)
            DispatchQueue.main.async { [imageView] in guard let image else { return }
            
            imageView.image = image
            }
        }
        dataTask?.resume()
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
