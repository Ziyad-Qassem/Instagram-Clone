//
//  SettingsViewModel.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 16/10/2024.
//

import Foundation
import FirebaseAuth
class SettingsViewModel {
    var errormessage : String = ""
    
    
    func  logout(completion : (Bool) -> ()) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch{
            errormessage = error.localizedDescription
            completion(false)
            return
        }
    }
    
    
    
}
