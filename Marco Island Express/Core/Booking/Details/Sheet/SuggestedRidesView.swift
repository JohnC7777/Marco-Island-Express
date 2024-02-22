//
//  SuggestedRidesView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/17/24.
//

import SwiftUI

struct SuggestedRidesView: View {
    var body: some View {
        VStack(alignment:.leading){
            Text("SUGGESTED RIDES")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.horizontal)
                .foregroundStyle(Color.theme.secondaryTextColor)
            ScrollView(.horizontal){
                HStack(spacing: 10){
                    RideOptionView(myVehicle: VehicleSelection(vehicleType: .sedan, price: 80.00, passengers: 3, icon: "Sedan"))
                    RideOptionView(myVehicle: VehicleSelection(vehicleType: .minivan, price: 90.00, passengers: 5, icon: "Minivan"))
                    RideOptionView(myVehicle: VehicleSelection(vehicleType: .suv, price: 100.00, passengers: 6, icon: "SUV"))
                }
                .padding(.leading)
            }
            
        }
    }
}

#Preview {
    SuggestedRidesView()
}
