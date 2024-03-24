//
//  DetailsSheetView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/24/24.
//

import SwiftUI

struct DetailsSheetView: View {
    @EnvironmentObject var vm : RideDetailsViewModel
    @EnvironmentObject var locationVm : LocationSearchViewModel

    var body: some View {
        VStack(alignment:.leading){
            SuggestedRidesView()
                .padding(.top)
            
            Divider()
                .padding(.vertical, 5)
            
            HStack{
                Text("NOTES")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .foregroundStyle(Color.theme.secondaryTextColor)
                TextField(text: $vm.notes, label: {
                    Text("Please enter some notes")
                })
                .textFieldStyle(.roundedBorder)
                .padding(.trailing)
            }
            
            DatePicker(selection: $vm.selectedDate, in: Date.now.addingTimeInterval(86400)...,label: {
                Text("PICKUP TIME")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(.leading)
                    .foregroundStyle(Color.theme.secondaryTextColor)
            })
            .foregroundStyle(Color.theme.primaryTextColor)
            .padding(.trailing)
            
            Divider()
            
            AccentButton(title:"REVIEW"){
                withAnimation{
                    locationVm.mapState = .review
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
}

struct DetailsSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = RideDetailsViewModel()
        return DetailsSheetView()
            .environmentObject(mockViewModel)
    }		
}
