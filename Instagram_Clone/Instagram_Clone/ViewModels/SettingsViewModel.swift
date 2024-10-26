//
//  SettingsViewModel.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 16/10/2024.
//

import Foundation
import FirebaseAuth

enum SettingsURL : String {
    case privacy , terms ,help
}


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
    func openURL(url : SettingsURL , completion : (URL?) -> () ){
        let settingURL : String
        switch url {
        case .terms:    settingURL = "https://help.instagram.com/581066165581870/?helpref=uf_share"
        case .privacy:  settingURL = "https://help.instagram.com/519522125107875/?helpref=uf_share"
        case .help:     settingURL = "https://help.instagram.com"
        }
       
        guard let url = URL(string: settingURL) else {
            completion(nil)
            return
        }
        completion(url)
       
        
        
        
    }
    
    
}
