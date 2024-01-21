//
//  VehicleTypes.swift
//  Marco Island Express
//
//  Created by United States MO on 1/20/24.
//

import Foundation

enum VehicleType: String, Identifiable {
    case sedan = "Sedan"
    case minivan = "Minivan"
    case suv = "Full Size SUV"

    var id: String { self.rawValue }
}
