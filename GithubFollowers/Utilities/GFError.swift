//
//  GFError.swift
//  GithubFollowers
//
//  Created by andry on 23/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername     = "This username has invalid characters, please try again."
    case unableToComplete    = "Unable to complete your request. Please check your internet connection."
    case invalidResponse     = "Invalid response from the server, please try again."
    case invalidData         = "The data received from the server was invalid, please try again"
    case unableToFavourite   = "There was an error favourating this user. Please try again."
    case alreadyInFavourites = "You've already favourited this user."
}
