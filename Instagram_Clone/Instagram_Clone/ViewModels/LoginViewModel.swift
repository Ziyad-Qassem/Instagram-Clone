//
//  LoginViewModel.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import Foundation
import FirebaseAuth

class LoginViewModel {
     
    var errorMessage: String = ""
    private let format = "SELF MATCHES %@"
    var completionHandler  :  (() -> ()) = {}

    func loginUser(email : String? , password : String?, completion : @escaping ((Bool) -> Void)) {
        if checkUserData(email: email, password: password){
            Auth.auth().signIn(withEmail: email!, password: password!) {[weak self] _ , error in
                guard error == nil else {
                    
                    self?.errorMessage = "couldn't sign in "
                    
                    completion(false)
                    return
                }
                
                completion(true)
                
            }
        }
        
    }
    
    private func checkUserData(email : String? , password : String?) -> Bool {
        
        guard let  userEmail = email  , let userPassword = password else {
            errorMessage = "please enter all fields"
            completionHandler()
            return false
        }
        
        
        if isValidEmail(email: userEmail) {
            errorMessage = "email is incorrect"
            completionHandler()
            return false
        }
        else if isValidPassword(password: userPassword) {
            errorMessage = "password is incorrect"
            completionHandler()
            return false
        }
        
        return true
        
    }
    
    func isValidEmail(email: String) -> Bool {
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let pred = NSPredicate(format: format, regex)
            return pred.evaluate(with: email)
        }
        
    func isValidPassword(password: String) -> Bool {
        let regex = "(?=.[A-Z])(?=.[0-9])(?=.*[a-z]).{8,}"
        let pred = NSPredicate(format: format, regex)
        return pred.evaluate(with: password)
    }
}
