//
//  GFButton.swift
//  GihubFollowers
//
//  Created by andry on 17/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//

import UIKit

class GFButton: UIButton {
    
    // MARK: - override init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // MARK: - required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - init
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    // MARK: - configure
    private final func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - set
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
}
