//
//  LocationDetailsSubview.swift
//  Marco Island Express
//
//  Created by United States MO on 1/27/24.
//

import SwiftUI

struct LocationDetailsSubview: View {
    @EnvironmentObject var vm : LocationSearchViewModel
    @EnvironmentObject var detailsViewModel : RideDetailsViewModel
    var body: some View {
        VStack(alignment:.leading){
            MiniLocationDetailView(icon: "mappin.circle", title:vm.fromLocation?.title ?? "", subtitle:vm.fromLocation?.subtitle ?? "", time: detailsViewModel.selectedDate)
            
            Rectangle()
                .foregroundStyle(Color.theme.primaryTextColor)
                .frame(width: 1, height: 8)
                .padding(.leading)
                .padding(.leading, 8)
            
            MiniLocationDetailView(icon: "mappin.circle", title:vm.toLocation?.title ?? "", subtitle:vm.toLocation?.subtitle ?? "", time: detailsViewModel.selectedDate.addingTimeInterval(vm.travelTime ?? 0))
        }
    }
}

struct MiniLocationDetailView: View {
    let icon : String
    let title : String
    let subtitle : String
    let time : Date
    var body: some View {
        HStack{
            Image(systemName:icon)
            VStack(alignment:.leading){
                Text(title)
                    .foregroundStyle(Color.theme.primaryTextColor)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(Color.theme.secondaryTextColor)
                    .lineLimit(1)
            }
            Spacer()
            Text(time.showTime())
                .foregroundStyle(Color.theme.secondaryTextColor)
        }
        .padding(.horizontal)
    }	
}

