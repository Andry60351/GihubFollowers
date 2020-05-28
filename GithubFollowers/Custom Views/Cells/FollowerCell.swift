//
//  FollowerCell.swift
//  GithubFollowers
//
//  Created by andry on 20/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    // MARK: - variables
    static let reuseID  = "FollowerCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel   = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // MARK: - required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - setFollowerUsernameAndAvatar
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    // MARK: - configure
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
