//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by andry on 25/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    // MARK: - configureItems
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    // MARK: - actionButtonTapped
    override func actionButtonTapped() {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers", buttonTitle: "Ok")
            return
        }
        delegate.didTapGetFollowers(for: user)
        dismiss(animated: true)
    }
}
