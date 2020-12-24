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
    
    // Moc models of the collectionView here
    
    
    // Add a collectView here...
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.titleView = searchBar
        
        // create the UICollectionView here...
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // Registering cells here
        collectionView?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionView = collectionView else {
            
            return
        }
        
        view.addSubview(collectionView)
        
        // Assigned the SearchBar delegate to get some view action
        searchBar.delegate = self
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
    }
    
    // Creating the selector here
    @objc private func didCancelSearch() {
        // Getting rid of the keyboard here
        searchBar.resignFirstResponder()
        // Getting rid of the cancel button
        navigationItem.rightBarButtonItem = nil
    }
    
    private func query(_ text: String) {
        // Perform the search in the backend
        
    }
}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Gaurd let be were cassing it Dequeing the cell here
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        // After cassing it next configure the cell
//        cell.configure(with: <#T##UserPost#>)
        
        return cell 
    }
    
}










