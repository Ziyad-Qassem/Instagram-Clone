//
//  DataBaseManager.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import Foundation
import FirebaseDatabase


public class DataBaseManager {
    
    static let shared = DataBaseManager()
 
    private let database = Database.database().reference()
    
    // checks if user name or email is already in the database
    
    public func cancreateNewUser(with email : String , username : String , completion : @escaping (Bool) -> Void
    )  {
        completion(true)
    }
    // adding a new user to database
    public func addNewUserTDatabase (with email : String , userName : String, completion : @escaping (Bool) -> Void) {
        database.child(email.createSafeDatabasekey()).setValue(["username" : userName]) { error, _ in
            if error == nil {
                completion(true)
            }
            else {
               completion(false)
                return
            }
        }
    }
    
  
}
