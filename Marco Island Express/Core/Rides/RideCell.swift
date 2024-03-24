//
//  RideCell.swift
//  Marco Island Express
//
//  Created by United States MO on 3/23/24.
//

import SwiftUI

struct RideCell: View {
    let ride: Ride
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                
                MiniDetailView(title: "Date", value: ride.pickupTime.showDateAndYear(), icon: "car.fill")
                    .padding(.leading)
                
                Divider()
                
                MiniLocationDetailView(icon: "mappin.circle", title:ride.fromTitle, subtitle: ride.fromSubtitle, time: ride.pickupTime)
                
                Rectangle()
                    .foregroundStyle(Color.theme.primaryTextColor)
                    .frame(width: 1, height: 8)
                    .padding(.leading)
                    .padding(.leading, 8)
                
                MiniLocationDetailView(icon: "mappin.circle", title:ride.toTitle, subtitle:ride.toSubtitle, time:ride.pickupTime.addingTimeInterval(ride.travelTime))
                
            }
            Image(systemName: "chevron.right")
                .padding(.trailing)
                .foregroundColor(.gray)
            
        }
        .padding(.vertical, 5)
        .background{
            RoundedRectangle(cornerRadius:10)
                .foregroundColor(Color.theme.secondaryBackgroundColor)
                .shadow(radius: 2)
        }
    }
}

