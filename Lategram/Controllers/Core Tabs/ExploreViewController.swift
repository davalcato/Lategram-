//
//  ExploreViewController.swift
//  Lategram
//
//  Created by Daval Cato on 12/1/20.
//

import UIKit

class ExploreViewController: UIViewController {
    
    // create a search bar here...
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.backgroundColor = .secondarySystemBackground
        
        return searchBar
    }()
    
    // Creating the property that will come from Firebase
    private var models = [UserPost]()
    
    
    // Moc models of the collectionView here
    
    
    // Add a collectView here...
    private var collectionView: UICollectionView?
    
    // Creating another collectioView here
    private var tabbedSearchCollectionView: UICollectionView?
    
    // Create the dim view
    private let dimmedView: UIView = {
        // Black view
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        view.alpha = 0
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // Consolidating the searchbar here
        configureSearchbar()
        // Configure the tabbedSearchCollection
        configureExploreCollection()
        // Consolidating the configureDimmedView
        configureDimmedView()
        configureSearchbar()
    }
    
    private func configureTabbedSearch() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.width/3, height: 52)
        layout.scrollDirection = .horizontal
        tabbedSearchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tabbedSearchCollectionView?.backgroundColor = .yellow
        
        tabbedSearchCollectionView?.isHidden = false
        // Unwrapping the tabbedSearchCollectionView
        guard let tabbedSearchCollectionView = tabbedSearchCollectionView else {
            return
            
        }
        
        tabbedSearchCollectionView.delegate = self
        tabbedSearchCollectionView.dataSource = self
        
        // View add subview
        view.addSubview(tabbedSearchCollectionView)
        
    }
    
    
    private func configureDimmedView() {
        view.addSubview(dimmedView)
        // When user taps dimmedView area it dismiss the view
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didCancelSearch))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        // Added this gesture to the dim view
        dimmedView.addGestureRecognizer(gesture)
    }
    
    // Consolidating the searchbar here
    private func configureSearchbar() {
        navigationController?.navigationBar.topItem?.titleView = searchBar
        searchBar.delegate = self
        
    }
    
    // Make the configureExploreCollection its own function
    private func configureExploreCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: (view.width-4)/3, height: (view.width-4)/3)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else {
            
            return
        }
        view.addSubview(collectionView)
        
    }
    
    
    // Assigned frames to the search collectionView
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // This shows the images in the search collectionView
        collectionView?.frame = view.bounds
        // Set the frames
        dimmedView.frame = view.bounds
//        tabbedSearchCollectionView?.frame = CGRect(x: 0,
//                                                   y: view.safeAreaInsets.top,
//                                                   width: view.width,
//                                                   height: 72)
    }
    
}

// Now conforming to the delegate
extension ExploreViewController: UISearchBarDelegate {
   
    // Gets called once the search button is tapped
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Tap to get rid of the keyboard here
        didCancelSearch()
        // Get the text out of the searchbar / and validating the text is not empty
        guard let text = searchBar.text, !text.isEmpty else {
            return
            
        }
        // If it is not empty we can prompt a search here
        query(text)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // When the user taps cancel get rid of keyboard
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didCancelSearch))
        
        // Animate the dim view here
        dimmedView.isHidden = false
        // Now animate the alpha
        UIView.animate(withDuration: 0.2, animations: {
            self.dimmedView.alpha = 0.4
        }) { done in
            // Once the animation is done
            if done {
                self.tabbedSearchCollectionView?.isHidden = false
            }
        }
    }
    
    // Creating the selector here
    @objc private func didCancelSearch() {
        // Getting rid of the keyboard here
        searchBar.resignFirstResponder()
        // Getting rid of the cancel button
        navigationItem.rightBarButtonItem = nil
        self.tabbedSearchCollectionView?.isHidden = true
        // Now animate the alpha
        UIView.animate(withDuration: 0.2, animations: {
            self.dimmedView.alpha = 0
            
            // It takes a parameter here
        }) { done in
            
            // Once the animation is done we hidden it in terms of the actual property
            if done {
                self.dimmedView.isHidden = true
            }
        }
    }
    // Perform the search in the backend
    private func query(_ text: String) {
        
        
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // Implementing the DataSource
        if collectionView == tabbedSearchCollectionView {
            return 0
        }
        
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tabbedSearchCollectionView {
            return UICollectionViewCell()
        }
        
        // Gaurd let be were cassing it Dequeing the cell here
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        // After cassing it next configure the cell
//        cell.configure(with: <#T##UserPost#>)
        cell.configure(debug: "test")
        return cell
    }
    
    // Implementing the UICollectionViewDelegate so when tapped cell it opens postView controller
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if collectionView == tabbedSearchCollectionView {
            // Change search context
            return
        }
        
        // Displacing the PostViewContioller 
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
        
        let vc = PostViewController(model: post)
        
        // Setting the Post title
        vc.title = post.postType.rawValue
        navigationController?.pushViewController(vc, animated: true)
    }
    
}










