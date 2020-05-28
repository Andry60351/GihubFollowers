//
//  GFSecondaryTitleLabel.swift
//  GithubFollowers
//
//  Created by andry on 23/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
    // MARK: - override init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - init
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        self.textAlignment = .left
        configure()
    }
    
    // MARK: - configure
    private final func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
