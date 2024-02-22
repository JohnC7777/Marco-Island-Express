//
//  RideOptionView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/17/24.
//

import SwiftUI

struct RideOptionView: View {
    @EnvironmentObject var vm : RideDetailsViewModel
    let myVehicle : VehicleSelection
    var body: some View {
        HStack{
            ZStack{
                Color.clear
                    .frame(width: 50, height: 0)
                
                Image(myVehicle.icon)
                    .resizable()
                    .frame(width: 88.25, height: 50)
                    .scaleEffect(x: -1, y: 1)
            }
            .padding(.leading, vm.selectedVehicle == myVehicle.vehicleType ? 8 : 0)
            
            VStack(alignment:.leading){
                Text(myVehicle.vehicleType.rawValue)
                    .font(.system(size: 16, weight: .bold))
                Text(myVehicle.price.formatPrice())
                    .font(.system(size: 14, weight: .regular))
            }
            .foregroundStyle(vm.selectedVehicle == myVehicle.vehicleType ? .white : .black)
            .padding(.trailing)
            .padding(.vertical)
            
            
        }
        .scaleEffect(vm.selectedVehicle == myVehicle.vehicleType ? 1.1 : 1.0)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(vm.selectedVehicle == myVehicle.vehicleType ? .linearGradient(colors: [Color.theme.accentColor,.green], startPoint: .leading, endPoint: .trailing) : .linearGradient(colors: [Color.theme.secondaryBackgroundColor, Color.theme.secondaryBackgroundColor], startPoint: .leading, endPoint: .trailing))
        }
        .opacity(vm.selectedVehicle == myVehicle.vehicleType ? 1.0 : 0.8)
        .onTapGesture {
            withAnimation{
                vm.selectedVehicle = myVehicle.vehicleType
            }
        }
    }
}


struct RideOptionView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = RideDetailsViewModel()
        return RideOptionView(myVehicle: VehicleSelection(vehicleType: .sedan, price: 80.00, passengers: 3, icon: "Tesla"))
            .environmentObject(mockViewModel)
    }
}
