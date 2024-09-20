//
//  HomeViewModel.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import Foundation
import FirebaseAuth

class HomeViewModel {
    
    
    func checkUserAuthenticatinStatus() -> Bool {
        // check user loged in or not
       
        return Auth.auth().currentUser == nil
    }
    
    
}

