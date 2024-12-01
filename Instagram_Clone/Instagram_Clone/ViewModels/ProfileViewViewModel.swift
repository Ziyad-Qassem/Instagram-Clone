//
//  ProfileViewViewModel.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 26/10/2024.
//

import Foundation
class ProfileViewViewModel {
    
    var username : String?
    private var userPost : [UserPost] = []
    
    
    func fetchUserPosts(completion:   (Error?) -> Void) {
        if self.username != nil {
            // get the user info that was tapped on from either the following or followers list
        }
        else{
            // get my user data
        }
    }
    
    func getPostINfo(at index: Int) -> UserPost {
        userPost[index]
    }
    func getUsersPosts() -> [UserPost] {
        userPost
    }
    func numberOfPosts() -> Int {
        userPost.count
    }
    func sendPostData(index : Int){
        
    }
    
}
