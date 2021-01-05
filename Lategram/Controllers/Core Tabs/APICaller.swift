//
//  APICaller.swift
//  Lategram
//
//  Created by Daval Cato on 1/3/21.
//

import Foundation

class APICaller {
    
    func apiCaller(page1: Int) {
        let mypage = String(page1)
        let request: String = String.init(format:"apiCaller", mypage)
        print(request)
    }
    
    
    // Make it a boolean here
     var isPaginating = false
    
    // To Mock the data here
    func fetchData(pagination: Bool = false, completion: @escaping (Result<[String], Error>) -> Void) {
        if pagination {
            isPaginating = true
            
        }
        // Add a delay
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2), execute: {
            let originalData = ["test"]
            
            let newData = [
                "banana", "oranges", "grapes", "Food",
            ]
            
            // Calling the completion handler
            completion(.success(pagination ? newData : originalData ))
            if pagination {
                self.isPaginating = false
            
            }
        })
        
    }
    
    
}











