//
//  Ride.swift
//  Marco Island Express
//
//  Created by United States MO on 3/23/24.
//
import Foundation
import SwiftUI
import MapKit

struct Ride: Identifiable, Hashable {
    
    var id: String
    var driverFirstName: String?
    var driverID: String?
    var driverLastName: String?
    var driverPhone: String?
    var airline: String?
    var flightNumber: String?
    var fromSubtitle: String
    var fromTitle: String
    var fromLat: CLLocationDegrees
    var fromLon: CLLocationDegrees
    var toLat: CLLocationDegrees
    var toLon: CLLocationDegrees
    var notes: String //Needed?
    var paymentMethod: String
    var pickupTime: Date
    var createdTime: Date
    var travelTime: Double
    var price: Double
    var tip: Double
    var requesterFirstName: String
    var requesterID: String
    var requesterLastName: String
    var requesterPhone: String
    var status: String //Can we make this an enum?
    var toSubtitle: String
    var toTitle: String
    var requesterFcmToken: String? // Optional?
    var driverPaid: Bool //Should we have this?
    var platform: String //Can we make this an enum?
    
    //TODO: Add an init that will convert the data correctly
    
}
