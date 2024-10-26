//
//  EditProfileViewModel.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 16/10/2024.
//

import Foundation
class EditProfileViewModel {
   // this dictioinary is to detect which value changed
    private var changedValues: [String:String] = [:]
    
    func configureModels() -> [String] {
        
        
        return ["value1", "value2", "value3" , "value4", "value5" , "value6" , "value7"]
    }
    func updateDataBase () {
        
    }
    func whichModelIsChanged (changedModel : EditProfileFormModel) {
        changedValues[changedModel.title] = changedModel.value
    }
}

