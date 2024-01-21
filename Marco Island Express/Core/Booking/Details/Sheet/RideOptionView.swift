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
        
        ZStack{
            VStack(alignment:.leading){
                Text(myVehicle.vehicleType.rawValue)
                    .font(.system(size: 16, weight: .bold))
                    .offset(x:25)
                Text(myVehicle.price.formatPrice())
                    .font(.system(size: 14, weight: .regular))
                    .offset(x:25)
            }
            .foregroundStyle(vm.selectedVehicle == myVehicle.vehicleType ? .white : .black)
            .frame(width: 120, height: 70)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(vm.selectedVehicle == myVehicle.vehicleType ? .linearGradient(colors: [Color.theme.accentColor,.green], startPoint: .leading, endPoint: .trailing) : .linearGradient(colors: [Color.theme.secondaryBackgroundColor, Color.theme.secondaryBackgroundColor], startPoint: .leading, endPoint: .trailing))
            }
            
            Image(myVehicle.icon)
                .resizable()
                .frame(width: 88.25, height: 50)
                .scaleEffect(x: -1, y: 1)
                .offset(x:-45)
        }
        .opacity(vm.selectedVehicle == myVehicle.vehicleType ? 1.0 : 0.8)
        .scaleEffect(vm.selectedVehicle == myVehicle.vehicleType ? 1.1 : 1.0)
        .onTapGesture {
            withAnimation{
                vm.selectedVehicle = myVehicle.vehicleType
            }
        }
        
        
        
        
        /*ZStack{
            VStack(alignment:.leading){
                Text(myVehicle.vehicleType.rawValue)
                    .font(.system(size: 14, weight: .bold))
                Text(myVehicle.price.formatPrice())
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding(25)
            .padding(.leading, 80)
            .foregroundStyle(vm.selectedVehicle == myVehicle.vehicleType ? .white : .black)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(vm.selectedVehicle == myVehicle.vehicleType ? .linearGradient(colors: [Color.theme.accentColor,.green], startPoint: .leading, endPoint: .trailing) : .linearGradient(colors: [Color(.systemGray4),Color(.systemGray2)], startPoint: .leading, endPoint: .trailing))
            }
            
            Image(myVehicle.icon)
                .resizable()
                .frame(width: 141.25, height: 80)
                .scaleEffect(x: -1, y: 1)
                .offset(x:-70)
        }
        .padding()
        
        .scaleEffect(vm.selectedVehicle == myVehicle.vehicleType ? 1.25 : 1.0)
        .onTapGesture {
            withAnimation{
                vm.selectedVehicle = myVehicle.vehicleType
            }
        }*/
        
        /*VStack(alignment:.leading){
            HStack{
                Image(myVehicle.icon)
                    .resizable()
                    .frame(width: 40, height: 25)
                HStack(spacing:0){
                    Image(systemName: "person.fill")
                    Text("\(myVehicle.passengers)")
                }
            }
            
            VStack(spacing: 4){
                Text("\(myVehicle.vehicleType.rawValue)")
                    .font(.system(size: 14, weight: .semibold))
                Text(myVehicle.price.formatPrice())
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding(.top, 4)
        }
        .frame(width: 112, height: 100)
        .scaleEffect(vm.selectedVehicle == myVehicle.vehicleType ? 1.25 : 1.0)
        .background{
                RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(vm.selectedVehicle == myVehicle.vehicleType ? Color.theme.accentColor : Color.theme.secondaryBackgroundColor)
        }
        .onTapGesture {
            withAnimation{
                vm.selectedVehicle = myVehicle.vehicleType
            }
        }*/
    }
}


struct RideOptionView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = RideDetailsViewModel()
        //mockViewModel.selectedVehicle = .minivan

        return RideOptionView(myVehicle: VehicleSelection(vehicleType: .sedan, price: 80.00, passengers: 3, icon: "Tesla"))
            .environmentObject(mockViewModel)
    }
}
