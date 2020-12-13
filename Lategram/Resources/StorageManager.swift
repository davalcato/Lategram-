//
//  StorageManager.swift
//  Lategram
//
//  Created by Daval Cato on 12/6/20.
//

import FirebaseStorage

public class StorageManager {
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    // Passing in our own error handling here...
    public enum IGStoreManagerError: Error {
        case failedToDownload
    }
    
    // MARK: - Public
    public func uploadUserPost(model: UserPost, completion: @escaping (Result <URL, Error>) -> Void) {
        
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result <URL, IGStoreManagerError>) -> Void) {
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                
                return
            }
            
            // if successful pass the completion with the url...
            completion(.success(url))
            
        })
    }
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











