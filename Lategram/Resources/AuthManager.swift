//
//  AuthManager.swift
//  Lategram
//
//  Created by Daval Cato on 12/6/20.
//

import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func registerNewUser(username: String, email: String, password: String) {
        
        
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        // if the logger is signing in with an email...
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                    
                }
                completion(true)
            }
            
        }
        else if let username = username {
            // username log in
            print(username)
        }
    }
    
}
