//
//  NotificationsViewController.swift
//  Lategram
//
//  Created by Daval Cato on 12/1/20.
//

import UIKit

enum UIUserNotificationType {
    case like(post: UserPost)
    // If current follower is following back pass in State
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UIUserNotificationType
    let text: String
    let user: User
}

final class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // add tableview here...
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationLikeEventTableViewCell.self, forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        return tableView
        
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private lazy var noNotificationsView = NoNotificationsView()
    
    // A collection of these model types
    private var models = [UserNotification]()
    
    
    // MARK: - Lifecycle
      
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        navigationItem.title = "Notifications"
        view.backgroundColor = .systemBackground
//        spinner.startAnimating()
        // Add a subview to make the request
        view.addSubview(spinner)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0,
                               y: 0,
                               width: 100,
                               height: 100)
        spinner.center = view.center
        
    }
    
    private func fetchNotifications() {
        for x in 0...100 {
            let user = User(username: "Joie",
                            bio: "",
                            name: (first: "", last: ""),
                            profilePhoto: URL(string: "https://www.google.com")!,
                            birth: Date(),
                            gender: .male,
                            count: UserCount(followers: 1, following: 1, posts: 1),
                            joinDate: Date())
            let post = UserPost(identifier: "",
                                postType: .photo,
                                thumbnailImage: URL(string: "https://www.google.com")!,
                                postURL: URL(string: "https://www.google.com")!,
                                caption: nil,
                                likeCount: [],
                                comments: [],
                                createdDate: Date(),
                                taggedUsers: [],
                                owner: user)
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post) : .follow(state: .not_following),
                                         text: "Hello Joie",
                                         user: user)
            models.append(model)
        }
    }
    
    //
    private func addNoNotificationView() {
        tableView.isHidden = true
        view.addSubview(tableView)
        noNotificationsView.frame = CGRect(x: 0,
                                           y: 0,
                                           width: view.width/2,
                                           height: view.width/4)
        noNotificationsView.center = view.center
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            // Like cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            
            cell.configure(with: model)
            // Assign the delegate here
            cell.delegate = self
            return cell 
        case .follow:
            // follow cell
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
            
//            cell.configure(with: model)
            cell.delegate = self
        return cell
        
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
    
}
// Extend the NotificationViewController and conform to the NotificationLikeEventTableViewCellDelegate
extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        switch model.type {
        case .like(let post):
            // Create post controller here
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            
            // Now pushing the ViewContoller onto the screen here
            navigationController?.pushViewController(vc, animated: true)
            
        case .follow(_):
            fatalError("Dev Issue: Should never get called")
        }
        
    }
    
}
// Conform to the other cells
extension NotificationsViewController: NotificationFollowEventTableViewCellDelegate {
    func didTapFollowUnFollowButton(model: UserNotification) {
        print("Tapped button")
        // perform database update
        
    }
    
}













