//
//  FirebaseStorageService.swift
//  Music
//
//  Created by Enes Sancar on 09.12.2023.
//

import UIKit
import FirebaseStorage

protocol FirebaseStorageServiceProtocol: AnyObject {
    func upload(reference: StorageReference, data: Data, onSuccess: @escaping (StorageMetadata) -> Void, onError: @escaping (Error) -> Void)
    func download(reference: StorageReference, onSuccess: @escaping (URL) -> Void, onError: @escaping (Error) -> Void)
}

final class FirebaseStorageService: FirebaseStorageServiceProtocol {
    
    static let shared = FirebaseStorageService()
    
    private init() {}
    
    func upload(reference: StorageReference, data: Data, onSuccess: @escaping (StorageMetadata) -> Void, onError: @escaping (Error) -> Void) {
        reference.putData(data) { metadata, error in
            if let error { onError(error) }
            guard let metadata else { return }
            onSuccess(metadata)
        }
    }
    
    func download(reference: StorageReference, onSuccess: @escaping (URL) -> Void, onError: @escaping (Error) -> Void) {
        reference.downloadURL { url, error in
            if let error { onError(error) }
            guard let url else { return }
            onSuccess(url)
        }
    }
}
