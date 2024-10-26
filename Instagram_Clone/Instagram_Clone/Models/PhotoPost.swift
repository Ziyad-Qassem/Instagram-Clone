//
//  PhotoPost.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 16/10/2024.
//

import Foundation
public struct UserPost {
    let indentifier : String
    let postType : UserPostType
    let thumpnailImageURL : URL
    let postURL : URL
    let caption : String?
    let likes : [PostLikes]
    let comments : [PostComments]
    let createdDate : Date
    let taggedUsers: [User]
    
    
}

public struct PostLikes {
    let username : String
    let postIndetifier : String
    
}
public struct CommentLikes {
    let username : String
    let CommentIndetifier : String
    
}
public struct PostComments {
    let identifier : String
    let userName : String
    let comment : String
    let createdDate : Date
    let likes : [CommentLikes]
}

public enum UserPostType {
    case photo , video
}
