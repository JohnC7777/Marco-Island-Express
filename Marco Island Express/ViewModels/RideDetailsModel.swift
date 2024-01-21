//
//  RideSelectionDetailsModel.swift
//  Marco Island Express
//
//  Created by United States MO on 1/20/24.
//


import SwiftUI

class RideDetailsViewModel: ObservableObject {
    
    @Published var notes = ""
    @Published var carSeat : CarSeatType = .none
    @Published var selectedDate = Date.now
    @Published var showDatePicker = false
    @Published var selectedVehicle : VehicleType = .sedan
    
}

