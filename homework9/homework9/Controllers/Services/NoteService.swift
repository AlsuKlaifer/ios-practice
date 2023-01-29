//
//  NoteManager.swift
//  homework9
//
//  Created by Alsu Faizova on 10.12.2022.
//

import UIKit

enum NoteServiceError: Error {
    case fileNotFound
    case couldNotReadFile
    case couldNotCreateFileName
    case couldNotCreateImageData
}

class NoteService {
    
    private let fileManager: FileManager
    private let dataSourseURL: URL
    private let imageExtension: String = "png"

    init() {
        fileManager = .default

        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("Could not load documents directory")
        }
        self.dataSourseURL = documentsDirectory
        print("Initialized documents directory at \(dataSourseURL.path())")
    }
    
    func save(image: UIImage, imageName: String) throws {
        guard let data = image.pngData() else {
            throw NoteServiceError.couldNotCreateImageData
        }
        guard let imageTitle = encode(string: "\(imageName).\(imageExtension)") else {
            throw NoteServiceError.couldNotCreateFileName
        }

        let path = dataSourseURL.appending(path: imageTitle).path()
        fileManager.createFile(atPath: path, contents: data)
    }
    
    func getImage(imageName: String) throws -> UIImage {
        let path = dataSourseURL.appending(path: "\(imageName).\(imageExtension)").path()
        guard fileManager.fileExists(atPath: path) else {
            throw NoteServiceError.fileNotFound
        }

        guard let data = fileManager.contents(atPath: path) else {
            throw NoteServiceError.couldNotReadFile
        }
        return  UIImage(data: data)!
    }

    private func encode(string: String) -> String? {
        string.addingPercentEncoding(
            withAllowedCharacters: .init(charactersIn: " ()")
                .union(.urlPathAllowed)
        )
    }
}
