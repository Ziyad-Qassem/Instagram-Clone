//
//  RegistrationViewModel.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import Foundation
import FirebaseAuth
class RegistrationViewModel {
    var errorMessage : String?
    private let format = "SELF MATCHES %@"
    func createUser (userEmail : String? , userPassword : String? , userName : String? ) -> Bool {
        guard  userEmail != nil , userPassword != nil , userName != nil else {
            errorMessage = "Please fill all the Text fields"
            return false
        }
        if isValidEmail(email: userEmail!) , isValidPassword(password: userPassword!) {
            var check = true
            Auth.auth().createUser(withEmail: userEmail!, password: userPassword!) { _, error in
                if error != nil {
                    self.errorMessage = error?.localizedDescription
                    check = false
                }
            }
            return check
        }
        else {
            errorMessage = "please check that the email is in the right form or the password has numbers"
            return false
        }
        
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
