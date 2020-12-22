//
//  ViewController.swift
//  Lategram
//
//  Created by Daval Cato on 12/1/20.
//

import UIKit
import FirebaseAuth

// Created model HomeFeedRenderViewModel to encapsule four view models
struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let actions: PostRenderViewModel
    let comments: PostRenderViewModel

}

class HomeViewController: UIViewController {
    
    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        // registrating the cells here...
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        
        return tableView
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        createMocModels()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    private func createMocModels() {
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
        
        // A collection of PostComments here 
        var comments = [PostComment]()
        for x in 0..<2 {
            comments.append(PostComment(identifier: "\(x)",
                                        username: "Draya",
                                        text: "I like all your post so far!",
                                        createdDate: Date(),
                                        // Likes is an empty collection []
                                        likes: []))
            
        }
        
        // Create four models then append them here
        for x in 0..<5 {
            let viewModel = HomeFeedRenderViewModel(header: PostRenderViewModel(renderType: .header(provider: user)),
                                                    post: PostRenderViewModel(renderType: .primaryContent(provider: post)),
                                                    actions: PostRenderViewModel(renderType: .actions(provider: "")),
                                                    comments: PostRenderViewModel(renderType: .comments(comments: comments)))
            feedRenderModels.append(viewModel)
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        // Determining which model the user wants
        let model: HomeFeedRenderViewModel
        if x == 0 {
             model = feedRenderModels[0]
        }
        else {
            // This gives the position of the model that we want
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
             model = feedRenderModels[position]
        }
        
        // Determining which position the user is at
        let subSection = x % 4
        
        if subSection == 0 {
            // header
            return 1
        }
        else if subSection == 1 {
            // post
            return 1
        }
        else if subSection == 2 {
            // actions
            return 1
        }
        else if subSection == 3 {
            // comment
            // Get the comment model out of the primary model
            let commentsModel = model.comments
            
            switch commentsModel.renderType {
            case .comments(let comments): return comments.count > 2 ? 2 : comments.count
            case .header, .actions, .primaryContent: return 0
            
            }
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        // Determining which model the user wants
        let model: HomeFeedRenderViewModel
        if x == 0 {
             model = feedRenderModels[0]
        }
        else {
            // This gives the position of the model that we want
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
             model = feedRenderModels[position]
        }
        
        let subSection = x % 4
        
        if subSection == 0 {
            // header
            let headerModel = model.header
            switch headerModel.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                return cell
                // Return a cell instead of a number UITableViewCell
            case .comments, .actions, .primaryContent: return UITableViewCell()
            }
        }
        else if subSection == 1 {
            // post
            let postModel = model.post
            switch postModel.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                return cell
            case .comments, .actions, .header: return UITableViewCell()
                
            }
        }
        else if subSection == 2 {
            // actions
            let actionSection = model.actions
            switch actionSection.renderType {
            case .actions(let provider):
                // Configure the cell views
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
                return cell
            case .comments, .header, .primaryContent: return UITableViewCell()
            }
        }
        else if subSection == 3 {
            // Get the comment model out of the primary model
            let commentModel = model.comments
            switch commentModel.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            case .header, .actions, .primaryContent: return UITableViewCell()
            }
            
        }
            return UITableViewCell()
            
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return feedRenderModels.count * 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let subSection = indexPath.section % 4
        if subSection == 0 {
            // Return the height for the header
            return 70
        }
        else if subSection == 1 {
            return tableView.width
            
        }
        else if subSection == 2 {
            return 60
            
        }
        else if subSection == 3 {
            return 50
        }
            return 0
        }
    }


