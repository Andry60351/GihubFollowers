//
//  SearchVC.swift
//  GihubFollowers
//
//  Created by andry on 16/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    // MARK: - properties
    
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Git Followers")
    var logoImageViewTopConstraint: NSLayoutConstraint!
    
    var isUsernameEntered: Bool { return !usernameTextField.text!.isEmpty }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text = ""
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: -createDismissKeyboardTapGesture
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: -pushFollowerListVC
    @objc func pushFollowerListVC() {
        
        guard isUsernameEntered else { 
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😃.", buttonTitle: "Ok")
            return
        }
        usernameTextField.resignFirstResponder()
        let followerListVC = FollowerListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    // MARK: - configureLogoImageView
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let topConstraintConstant: CGFloat = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 20 : 80
        
        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
        logoImageViewTopConstraint.isActive = true
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    // MARK: - configureTextField
    func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - configureCallToAction
    func configureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        view.addSubview(callToActionButton)
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50) 
        ])
    }
}

// MARK: - extensions
extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Did tap return")
        pushFollowerListVC()
        return true
    }
}

