//
//  GFItemInfoVC.swift
//  GithubFollowers
//
//  Created by andry on 25/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//


import UIKit

class GFItemInfoVC: UIViewController {
    
    // MARK: - variables
    let stackView       = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton    = GFButton()
    
    var user: User!
    weak var delegate: userInfoVCDelegate!

    
    // MARK: - init
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    // MARK: - required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureActionButton()
        layoutUI()
        configureStackView()
    }
    
    // MARK: - configureBackgroundView
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
    }
    
    // MARK: - configureActionButton
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - actionButtonTapped
    @objc func actionButtonTapped() {}
    
    // MARK: - configureStackView
    private func configureStackView() {
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    // MARK: - layoutUI
    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
