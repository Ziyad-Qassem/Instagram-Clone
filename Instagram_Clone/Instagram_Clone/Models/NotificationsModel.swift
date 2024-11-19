//
//  NotificationsModel.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 01/11/2024.
//

import Foundation
struct NotificationsModel {
    let notificationMessage : String
    let followingUser : User
    let notificationDate : Date
    let notificationType : NotificationType

    
    }

enum NotificationType {
    case follow(state : FollowState)
    case like(post : UserPost)
}
