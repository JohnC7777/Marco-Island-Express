//
//  RideDetailsSubview.swift
//  Marco Island Express
//
//  Created by United States MO on 1/27/24.
//

import SwiftUI

struct RideDetailsSubview: View {
    @EnvironmentObject var vm : RideDetailsViewModel
    var body: some View {
        HStack{
            RideOptionView(myVehicle: VehicleSelection(vehicleType: .sedan, price: 80.00, passengers: 5, icon: "Tesla"))
            
            VStack(alignment:.leading){
                MiniDetailView(title: "Date", value: vm.selectedDate.showDateAndYear(), icon: "calendar")
                MiniDetailView(title: "Notes", value: vm.notes, icon: "person")
            }
        }
    }
}

struct MiniDetailView: View {
    let title : String
    let value : String
    let icon : String
    var body: some View{
        HStack{
            Image(systemName:icon)
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundStyle(Color.theme.primaryTextColor)

            VStack(alignment:.leading){
                Text(title)
                    .foregroundStyle(Color.theme.secondaryTextColor)
                Text(value)
                    .foregroundStyle(Color.theme.primaryTextColor)
                    .font(.subheadline)
            }
        }
    }
}


struct RideDetailsSubview_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = RideDetailsViewModel()
        return RideDetailsSubview()
            .environmentObject(mockViewModel)
    }
}
