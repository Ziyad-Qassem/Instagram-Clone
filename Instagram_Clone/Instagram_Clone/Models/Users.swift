//
//  File.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 25/10/2024.
//

import Foundation
struct User {
    let username : String
    let name : (first : String , last : String)
    let birthDate : Date
    let gender : GenderType
    let counts : UsersCounts
    let joinDate : Date
    let profilePicture : URL
}

enum GenderType {
    case male , female
}

struct UsersCounts {
    let fellowers : Int
    let posts : Int
    let fellowing : Int
}
