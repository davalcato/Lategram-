//
//  ViewController.swift
//  Lategram
//
//  Created by Daval Cato on 12/1/20.
//

import UIKit
import FirebaseAuth

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        handleNotAuthenticated()
        
    }
    
    private func handleNotAuthenticated() {
        // Check auth Status
        if Auth.auth().currentUser == nil {
            // Show that the user is logged in
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
            
        }
    }
    
}

