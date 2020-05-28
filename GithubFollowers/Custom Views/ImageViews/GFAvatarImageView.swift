//
//  GFAvatarImageView.swift
//  GithubFollowers
//
//  Created by andry on 20/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let placeHolderImage = UIImage(named: "avatar-placeholder")!
    
    // MARK: - override init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    // MARK: - required init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - downloadImage
    func downloadImage(from urlString: String) {
        let cacheKey    = NSString(string: urlString)
        if let image    = cache.object(forKey: cacheKey) {
            self.image  = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data  = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            self.cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async { self.image = image }
        }
        
        task.resume()
    }
}
