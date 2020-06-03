//
//  GFTabBarController.swift
//  GithubFollowers
//
//  Created by andry on 29/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavouriteNC()]
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavouriteNC() -> UINavigationController {
        let favouriteVC = FavouritesListVC()
        favouriteVC.title = "Favourites"
        favouriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favouriteVC)
    } 
}
