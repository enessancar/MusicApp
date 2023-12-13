//
//  AlamofireService.swift
//  MusicApp
//
//  Created by Enes Sancar on 9.12.2023.
//

import Alamofire

protocol ServiceProtocol: AnyObject {
    func fetch<T: Codable>(path: String, onSuccess: @escaping (T) -> (), onError: @escaping (AFError) -> ())
}

final class AlamofireService: ServiceProtocol {
    
    static let shared = AlamofireService()
    private init () {}
    
    func fetch<T: Codable>(path: String, onSuccess: @escaping (T) -> (), onError: @escaping (AFError) -> ()) {
        
        AF.request(path).validate().responseDecodable(of: T.self) { response in
            if let error = response.error { onError(error) }
            guard let model = response.value else { return }
            onSuccess(model)
        }
    }
}
