//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by andry on 19/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//

import UIKit

class NetworkManager {
    static let shared   = NetworkManager()
    private let baseUrl         = "https://api.github.com/users/"
    let cache           = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completed: @escaping(Result<[Follower], GFError>) -> Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // if there is an error, return
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            // if the response was successful (response of 200) move on, otherwise return
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.userNotFound))
                return
            }
            
            // then, if the data is not nil move on, otherwise return
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder() // creating a JSONDecoder
                decoder.keyDecodingStrategy = .convertFromSnakeCase // decode from snakeCase
                
                // try to decode that data into a type of array of Follower
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                // if something goes wrong, return
                completed(.failure(.invalidData))
            }
            
        }        
        task.resume()
    }
}
