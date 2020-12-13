//
//  Models.swift
//  Lategram
//
//  Created by Daval Cato on 12/13/20.
//

import Foundation

enum Gender {
    case male, female, other 
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birth: Date
    let gender: Gender
    let count: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}

public enum UserPostType{
    case photo, video
    
}
/// Here is the user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // Video or full resolution photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    
    // Hold usernames here...
    let taggedUsers: [String]
}

struct PostLike {
    let username: String
    let postIdentifier: String
}

struct CommentLike {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
}




