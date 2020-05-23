//
//  UserInfoVC.swift
//  GithubFollowers
//
//  Created by andry on 23/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        print(username!)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
// pass username
// make network call
// populate ui
