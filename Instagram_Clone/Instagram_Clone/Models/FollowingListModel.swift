//
//  FollowingListModel.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 29/10/2024.
//

import Foundation

struct FollowingListModel {
    let userName: String
    let userTag : String
    let imageUrl: URL
    var typeOfFollow : FollowState
}

enum FollowState {
    case following , not_Flollowing
}
