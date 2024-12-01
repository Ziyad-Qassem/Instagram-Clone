//
//  StorageManager.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import Foundation
import FirebaseStorage

public enum IGSTorageError : Error {
    case failedtoDownload , failedtoUpload
}

public class StorageManager  {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    

    public func uploadUserPhotoPost(model : UserPost ,completion: @escaping (Result<URL , Error>) -> Void ){}
    
    public func downloadImage(with reference : String , Completion : @escaping
                              (Result<URL , IGSTorageError>) -> Void){
        bucket.child(reference).downloadURL { url, error in
            guard let url = url , error == nil else {
                Completion(.failure(.failedtoDownload))
                return
            }
            Completion(.success(url))
        }
        
        
    }
    
}
