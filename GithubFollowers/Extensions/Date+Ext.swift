//
//  Date+Ext.swift
//  GithubFollowers
//
//  Created by andry on 26/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//

import Foundation

extension Date {
    // MARK: - convertToMonthToYearFormat
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        
        return dateFormatter.string(from: self)
    }
}
