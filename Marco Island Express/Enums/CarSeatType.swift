//
//  CarSeatType.swift
//  Marco Island Express
//
//  Created by United States MO on 1/20/24.
//

import Foundation

enum CarSeatType: String, CaseIterable, Identifiable {
    case none = "None"
    case rearFacingInfant = "Rear facing infant seat"
    case forwardFacingToddler = "Forward facing toddler seat"
    case booster = "Booster seat"

    var id: String { self.rawValue }
}
