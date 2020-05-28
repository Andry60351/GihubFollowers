//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by andry on 25/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    // MARK: - actionButtonTapped
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }
    
    // MARK: - configureItems
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
}

