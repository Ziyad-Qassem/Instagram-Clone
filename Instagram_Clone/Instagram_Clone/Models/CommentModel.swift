//
//  CommentModel.swift
//  Instagram_Clone
//
//  Created by Ziyad Qassem on 02/11/2024.
//

import Foundation

struct Comment {
    let profileImage: URL
    let commentMessage: String
    let username: String
    let time: Date
    let isLiked: Bool
    let likesCount: Int
}
