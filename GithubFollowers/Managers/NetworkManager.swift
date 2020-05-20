//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by andry on 19/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    let baseUrl = "https://api.github.com/users/"
    
    private init() {}
    
    
    func getFollowers(for username: String, page: Int, completed: @escaping([Follower]?, String) -> Void) {
        let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(nil, "This username created an invalid request, please try again.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // if there is an error, return
            if let _ = error {
                completed(nil, "Unable to complete your request. Please check your internet connection.")
                return
            }
            
            // if the response was successful (response of 200) move on, otherwise return
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the server, please try again.")
                return
            }
            
            // then, if the data is not nil move on, otherwise return
            guard let data = data else {
                completed(nil, "The data received from the server was invalid, please try again")
                return
            }
            
            
            do {
                
                let decoder = JSONDecoder() // creating a JSONDecoder
                decoder.keyDecodingStrategy = .convertFromSnakeCase // decode from snakeCase
                
                // try to decode that data into a type of array of Follower
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers, "")
            } catch {
                // if something goes wrong, return
                completed(nil, "The data reveived from the server was invalid, please try again")
            }
            
        }        
        task.resume()
    }
}
