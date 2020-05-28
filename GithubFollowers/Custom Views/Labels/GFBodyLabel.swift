//
//  GFBodyLabel.swift
//  GihubFollowers
//
//  Created by andry on 17/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {
    
    // MARK: - override init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - init
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    // MARK: - configure
    private final func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
