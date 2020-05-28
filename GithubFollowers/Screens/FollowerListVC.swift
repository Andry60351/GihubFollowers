//
//  FollowerListVC.swift
//  GihubFollowers
//
//  Created by andry on 17/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//

import UIKit

protocol FollowerListVCDelegate: class {
    func didRequestFollowers(for username: String   )
}

final class FollowerListVC: UIViewController, UISearchBarDelegate {

    enum Section { case main }
    
    // MARK: - variables
    var username: String!
    var followers: [Follower] = []
    var page: Int = 1
    var filteredFollowers: [Follower] = []
    var hasMoreFollowers: Bool = true
    var isSearching: Bool = false
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
        
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()       
        
    }
    
    // MARK: - configureViewController
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
        
    // MARK: - configureCollectionView
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    // MARK: - configureSearchController
    func configureSearchController() {
        let searchController                        = UISearchController()
        searchController.searchResultsUpdater       = self
        searchController.searchBar.delegate         = self
        searchController.searchBar.placeholder      = "Search for a username"
        navigationItem.searchController             = searchController
        navigationItem.hidesSearchBarWhenScrolling  = false
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    
    // MARK: - getFollowers
    final func getFollowers(username: String, page: Int) {
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers, go follow them 😀."
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "An error has occured", message: error.rawValue, buttonTitle: "OK")
    
                // automatically pop the FollowerListVC controller if there is an error message
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    // MARK: - configureDataSource
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    // MARK: - updateData
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}

// MARK: - Extensions
extension FollowerListVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > (contentHeight - height) / 2 {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray         = isSearching ? filteredFollowers : followers
        let follower            = activeArray[indexPath.item]
        
        let destinationVC       = UserInfoVC()
        destinationVC.username  = follower.login
        destinationVC.delegate  = self
        
        let navController       = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
    }
    
}


extension FollowerListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) { updateData(on: followers)
        isSearching = false
    }
}

extension FollowerListVC: FollowerListVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
}


