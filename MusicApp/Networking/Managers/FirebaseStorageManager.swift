//
//  FirebaseStorageManager.swift
//  MusicApp
//
//  Created by Enes Sancar on 10.12.2023.
//

import UIKit
import FirebaseStorage

final class FirebaseStorageManager {
    
    private let userImageRef = Storage.storage()
        .reference()
        .child("Media/\(ApplicationVariables.currentUserID!).jpg")
    
    func uploadUserImage(image: UIImage, onSuccess: @escaping () -> (), onError: @escaping(String) -> ()) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        FirebaseStorageService.shared.upload(reference: userImageRef, data: imageData) { metadata in
            onSuccess()
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
    
    func fetchUserImage(onSuccess: @escaping (URL) -> Void, onError: @escaping (String) -> Void) {
        FirebaseStorageService.shared.download(reference: userImageRef) { url in
            onSuccess(url)
        } onError: { error in
            onError(error.localizedDescription)
        }
    }
}
