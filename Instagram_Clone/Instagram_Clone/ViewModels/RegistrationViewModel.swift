//
//  RegistrationViewModel.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 21/09/2024.
//

import Foundation
import FirebaseAuth
class RegistrationViewModel {
    
    var errorMessage : String = "" 
    
private let format = "SELF MATCHES %@"
    func createUserInFirebase (userEmail : String? , userPassword : String? , userName : String?  ,completion : @escaping (Bool) -> Void  )  {
        // checks nil values
        guard  let email  = userEmail , let password  = userPassword,  let name = userName else {
            errorMessage = "Please fill all the Text fields"
            completion(false)
            return
        }
        // checks the email and password is in the right form
        if isValidEmail(email: userEmail!) , isValidPassword(password: userPassword!) {
             // checks if the user email or name already exists in database
            
            DataBaseManager.shared.cancreateNewUser(with: email, username: name, completion: { canCreate in
                if canCreate {
                    // the email and username doesn't exist in the database so we can create a new user
                    Auth.auth().createUser(withEmail: email, password: password) { _, error in
                        if error == nil {
                            // now we create user in  the database
                            DataBaseManager.shared.addNewUserTDatabase(with: email, userName: name) { success in
                                if success {
                                    completion(true)
                                    return
                                }
                                else {
                                    self.errorMessage = "Error in adding user to database"
                                    completion(false)
                                    return
                                }
                            }
                            
                        }
                      // error in creating the user in firebase
                        else {
                            self.errorMessage = error!.localizedDescription
                            completion(false)
                            return
                        }
                    }
                }
                // the email or user name already exits in the data base
                else {
                    self.errorMessage = "user Already Exists"
                    completion(false)
                    return
                }
            })
        }
        else {
            errorMessage = "please check that the email is in the right form or the password has numbers"
            completion(false)
            return
        }
    }
  private  func isValidEmail(email: String) -> Bool {
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let pred = NSPredicate(format: format, regex)
            return pred.evaluate(with: email)
        }
        
 private func isValidPassword(password: String) -> Bool {
            let regex = "(?=.[A-Z])(?=.[0-9])(?=.*[a-z]).{8,}"
            let pred = NSPredicate(format: format, regex)
            return pred.evaluate(with: password)
        }
}
