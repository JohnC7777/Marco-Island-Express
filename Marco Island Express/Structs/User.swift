//
//  User.swift
//  Marco Island Express
//
//  Created by United States MO on 1/13/24.
//

import SwiftUI

struct User: Identifiable {
    var id : String
    var firstName: String
    var lastName: String
    var phoneNumber: String
    var role: String
    var newRideNotifications: Bool
    
    init?(data: [String: Any]) {
        guard let id = data["id"] as? String,
              let firstName = data["firstName"] as? String,
              let lastName = data["lastName"] as? String,
              let phoneNumber = data["phoneNumber"] as? String,
              let role = data["role"] as? String,
              let newRideNotifications = data["newRideNotifications"] as? Bool
        else { return nil }
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.role = role
        self.newRideNotifications = newRideNotifications
    }
}
