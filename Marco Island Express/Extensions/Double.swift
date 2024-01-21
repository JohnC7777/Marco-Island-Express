//
//  Double.swift
//  Marco Island Express
//
//  Created by United States MO on 1/20/24.
//

import Foundation

extension Double {
    func formatPrice() -> String {
        return String(format: "$%.2f", self)
    }
}
