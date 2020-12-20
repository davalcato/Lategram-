//
//  PostViewController.swift
//  Lategram
//
//  Created by Daval Cato on 12/1/20.
//

import UIKit

/*
 Section
 - Header Model
 
 Section
 - Post Cell Model

 Section
 - Action Buttons Cell Model
 
 Section
 - N Number of general Models for Comments
 

*/


// States of a rendered cell
enum PostRenderType {
    // The header providers a User object here 
    case header(provider: User)
    case primaryContent(provider: UserPost) // post
    case actions(provider: String) // like, comment, share
    case comments(comments: [PostComment])
}
// Model of rendered post
struct PostRenderViewModel {
    let renderType: PostRenderType
    
}

class PostViewController: UIViewController {
    
    // creating the model here
    private let model: UserPost?
    
    // Array of PostViewController type
    private var renderModels = [PostRenderViewModel]()
    
    //TableView here
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        // Register cells the tableVIew here
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        tableView.register(IGFeedPostActionsTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionsTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
       
        return tableView
    
    }()
    
    // MARK: Init
    
    // Initializing with a UserPost here
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        // Setting the frames here
        configureModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Rendering the model array in the tableView here
    private func configureModels() {
        guard let userPostModel = self.model else {
            return
            
        }
        // Set up the Models for our renderable cells
        
        // Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        
        // Post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(provider: userPostModel)))
        
        // Actions
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        
        // Comments
        var comments = [PostComment]()
        // Creating four of these in a four loop
        for x in 0..<4 {
            comments.append(
                PostComment(identifier: "123_\(x)",
                            username: "@Tanaya",
                            text: "Awesome Post!",
                            createdDate: Date(),
                            likes: []))
            
        }
        // Model for renderType 
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }

    
    
    // Added the tableView as a subview here 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground

    }
     
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Setting the frames here
        tableView.frame = view.bounds
    }
    
}

extension PostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .actions(let actions):
            // Configure the cell views
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionsTableViewCell.identifier, for: indexPath) as! IGFeedPostActionsTableViewCell
            return cell
            
        case .comments(let comments):
            var cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
            return cell
            
        case .primaryContent(let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
            return cell
            
        case .header(let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
            return cell
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .actions(_): return 1
        case .comments(let comments): return comments.count > 4 ? 4 : comments.count
        case .primaryContent(_): return 1
        case .header(_): return 1
            
        }
     
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = renderModels[indexPath.section]
        
        switch model.renderType {
        case .actions(_): return 60
        case .comments(_): return 50
        case .primaryContent(_): return tableView.width
        case .header(_): return 70
            
        }
    }
}









