//
//  RideDetailView.swift
//  Marco Island Express
//
//  Created by United States MO on 3/23/24.
//

import SwiftUI

struct RideDetailView: View {
    let ride: Ride
    @Binding var selected : Int
    var body: some View {
        VStack{
            //Status view
            StatusView()
            
            ZStack{
                
                UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 10, topTrailing: 10))
                    .foregroundStyle(Color.theme.secondaryBackgroundColor)
                
                VStack(alignment:.leading){
                    ScrollView{
                        HStack{
                            MiniDetailView(title: "Date", value: ride.pickupTime.showDateAndYear(), icon: "calendar")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            MiniDetailView(title: "Time", value: ride.pickupTime.showTime(), icon: "clock")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Divider()
                        
                        HStack{
                            MiniDetailView(title: "Car", value: "Sedan", icon: "car")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            MiniDetailView(title: "Notes", value: ride.notes, icon: "square.and.pencil")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Divider()
                        
                        HStack{
                            if let airline = ride.airline, let flightNumber = ride.flightNumber{
                                MiniDetailView(title: "Airline", value: airline, icon: "airplane")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                MiniDetailView(title: "Flight Number", value: flightNumber, icon: "number")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                        MapOverviewView(ride: ride)
                            .frame(minHeight: 225)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        MiniLocationDetailView(icon: "mappin.circle", title:ride.fromTitle, subtitle: ride.fromSubtitle, time: ride.pickupTime)
                        
                        Rectangle()
                            .foregroundStyle(Color.theme.primaryTextColor)
                            .frame(width: 1, height: 8)
                            .frame(maxWidth: .infinity)
                            .padding(.leading)
                            .padding(.leading, 8)
                        
                        MiniLocationDetailView(icon: "mappin.circle", title:ride.toTitle, subtitle:ride.toSubtitle, time:ride.pickupTime.addingTimeInterval(ride.travelTime))
                        
                        Divider()
                        
                        HStack{
                            if let first = ride.driverFirstName, let last = ride.driverLastName, let phone = ride.driverPhone{
                                MiniDetailView(title: "Driver", value: "\(first) \(last)", icon: "person.badge.shield.checkmark")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                MiniDetailView(title: "Phone", value: "\(phone)", icon: "phone")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                        Divider()
                        
                        HStack{
                            MiniDetailView(title: "Total Amount", value: (ride.price/100).formatPrice(), icon: "dollarsign")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            MiniDetailView(title: "Payment Method", value: ride.paymentMethod, icon: "creditcard")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                    }
                }
                .padding()
            }
        }
        .padding(.top)
        .background(Color.theme.backgroundColor)
        .navigationBarTitleDisplayMode(.inline)
    }
}

