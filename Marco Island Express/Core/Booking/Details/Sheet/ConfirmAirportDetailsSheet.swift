//
//  ConfirmAirportDetailsSheet.swift
//  Marco Island Express
//
//  Created by United States MO on 1/24/24.
//

import SwiftUI

struct ConfirmAirportDetailsSheet: View {
    @EnvironmentObject var locationVm : LocationSearchViewModel
    @EnvironmentObject var vm : RideDetailsViewModel
    @Environment(\.colorScheme) var colorScheme
    @State var flightNumber = ""
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(locationVm.fromLocation?.title ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                Image(systemName: "airplane.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(Color.theme.accentColor)
            }
            Text("Please confirm your airline below.")
                .foregroundStyle(Color.theme.secondaryTextColor)
            HStack{
                Picker(selection: $vm.airlineSelection, content: {
                    ForEach(vm.airlineOptions ?? [""], id: \.self) { option in
                        Text(option).tag(option)
                    }
                }, label: {
                    Text("Choose Your Airline")
                })
                .pickerStyle(.wheel)
                .frame(height: 120)
                
                TextField("Flight Number", text:$flightNumber)
                    .textFieldStyle(.plain)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    .background{
                        RoundedRectangle(cornerRadius: 7)
                            .foregroundStyle(colorScheme == .light ? Color(red: 242 / 255, green: 242 / 255, blue: 243 / 255) : Color(red: 42 / 255, green: 42 / 255, blue: 44 / 255))
                    }
                
            }
            
            AccentButton(title:"Confirm Pickup"){
                locationVm.fetchRoute()
            }
            .padding(.vertical)
            
        }
        .padding(.horizontal)
        .padding(.top)
        .onAppear{
            if let location = locationVm.fromLocation{
                vm.setAirlineOptions(location)
            }
        }
    }
}

#Preview {
    ConfirmAirportDetailsSheet()
}
