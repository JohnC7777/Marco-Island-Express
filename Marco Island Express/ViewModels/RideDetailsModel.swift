//
//  RideSelectionDetailsModel.swift
//  Marco Island Express
//
//  Created by United States MO on 1/20/24.
//


import SwiftUI

class RideDetailsViewModel: ObservableObject {
    
    @Published var notes = ""
    @Published var selectedDate = Date.now
    @Published var showDatePicker = false
    @Published var selectedVehicle : VehicleType = .sedan
    @Published var airlineOptions : [String]?
    @Published var airlineSelection : String = ""
    @Published var tipSelectedIndex : Int = 1
    @Published var tipAmount : Double? = 20.00
    
    func setAirlineOptions(_ location : Location){
        if !location.isAirport{
            return
        }
        //Check RSW
        if calculateDistance(lat1: location.coordinate.latitude, lng1: location.coordinate.longitude, lat2: 26.5279622, lng2: -81.7552328) < 1 {
            airlineOptions = ["Air Canada","American","Delta","Frontier","JetBlue","Southwest","Spirit","Sun Country","United","WestJet"]
        }
        
        //Check Punta Gorda
        if calculateDistance(lat1: location.coordinate.latitude, lng1: location.coordinate.longitude, lat2: 26.9162249, lng2: -81.9977903) < 1 {
            airlineOptions = ["Allegiant","Sun Country"]
        }
        
        //Check Miami
        if calculateDistance(lat1: location.coordinate.latitude, lng1: location.coordinate.longitude, lat2: 25.7950807, lng2: -80.2795994) < 1 {
            airlineOptions = ["American","Southwest","Delta","Spirit","United", "JetBlue", "Frontier","Air Canada","Sun Country","WestJet","Eastern","GlobalX","Other"]
        }
        
        //Check Fort Lauderdale
        if calculateDistance(lat1: location.coordinate.latitude, lng1: location.coordinate.longitude, lat2: 26.0714323, lng2: -80.1454997) < 1 {
            airlineOptions = ["Southwest","American","Delta","Spirit","United","JetBlue","Westjet","Other"]
        }
    }
    
    func calculateDistance(lat1: Double, lng1: Double, lat2: Double, lng2: Double) -> Double {
        let R = 6371.0 // Radius of the earth in km
        let dLat = deg2rad(deg: lat2 - lat1) // deg2rad below
        let dLng = deg2rad(deg: lng2 - lng1)
        
        let a = sin(dLat / 2) * sin(dLat / 2) +
                cos(deg2rad(deg: lat1)) * cos(deg2rad(deg: lat2)) *
                sin(dLng / 2) * sin(dLng / 2)
        
        let c = 2 * atan2(sqrt(a), sqrt(1 - a))
        let distance = R * c // Distance in km
        
        return distance
    }

    func deg2rad(deg: Double) -> Double {
        return deg * (Double.pi / 180.0)
    }
}

