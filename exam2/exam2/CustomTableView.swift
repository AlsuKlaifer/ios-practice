//
//  CustomTableView.swift
//  exam2
//
//  Created by Alsu Faizova on 19.11.2022.
//

import UIKit

class CustomTableViewCell: UICollectionViewCell{
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 35
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let value: UILabel? = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private var loadingTask: Task<Void, Never>?
    
    func set(text: String, imageUrl: URL, valueText: String) {
        title.text = text
        value?.text = valueText
        loadingTask?.cancel()
        loadingTask = Task {
            await loadImage(url: imageUrl)
        }
    }
    
    private func loadImage(url: URL) async {
        imageView.image = nil
        let urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData
        )
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            guard !Task.isCancelled else { return }
            imageView.image = UIImage(data: data)
        } catch {
            print("could not load image")
        }
    }
    
}
