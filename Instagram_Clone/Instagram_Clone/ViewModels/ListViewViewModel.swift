//
//  ListViewViewModel.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 30/10/2024.
//

import Foundation
class ListViewViewModel {
    
   
    
    private var followersList : [FollowingListModel] = []
    
    public func getUserFollowersList() -> [FollowingListModel] {
        // get user followers list from the database
        
        
        return followersList
    }
    
    public func getFollowInfoAtIndexPath(At indexPath : Int) -> FollowingListModel? {
        return followersList[indexPath]
    }
}
