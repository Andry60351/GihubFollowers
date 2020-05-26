//
//  String+Ext.swift
//  GithubFollowers
//
//  Created by andry on 26/05/2020.
//  Copyright © 2020 andry tafa. All rights reserved.
//

import Foundation

extension String {
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "uk")
        dateFormatter.timeZone = .current

        return dateFormatter.date(from: self)!
    }
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A"}
        return date.convertToMonthYearFormat()
    }
}
