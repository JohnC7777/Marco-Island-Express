//
//  Date.swift
//  Marco Island Express
//
//  Created by United States MO on 2/21/24.
//

import Foundation

extension Date {
    func showTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mma" // Format for Time
        return dateFormatter.string(from: self)
    }
}

extension Date {
    func showDateAndYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy" // Format for Month Day, Year
        return dateFormatter.string(from: self)
    }
}
