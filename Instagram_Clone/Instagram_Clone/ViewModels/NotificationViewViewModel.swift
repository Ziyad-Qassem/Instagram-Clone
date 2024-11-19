//
//  NotificationViewViewModel.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 01/11/2024.
//

import Foundation

class NotificationViewViewModel {
    
    private var userNotification : [NotificationsModel] = []
    
    func getAllNotifications() -> [NotificationsModel] {
         return userNotification
    }
    
    private func fetchNotifications() {
        
    }
    
    func getUserPost(at indexPath : Int) -> UserPost? {
     // get post from database
        return nil
    }
}
