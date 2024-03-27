//
//  RidesView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/12/24.
//

import SwiftUI

struct RidesView: View {
    @EnvironmentObject var userDetails: UserViewModel
    @State private var selected = 1
    var exampleRides : [Ride] = [Ride(id: "1341324", driverFirstName: "Patrick", driverID: "123123", driverLastName: "Baalman", driverPhone: "636-222-2222", airline: "American Airlines", flightNumber: "A1B2C3", fromSubtitle: "Ave Maria, FL, USA", fromTitle: "Ave Maria University", fromLat: 25.7602, fromLon: -80.1959, toLat: 26.3365, toLon: -81.4390, notes: "This is an example note", paymentMethod: "Cash", pickupTime: Date.now, createdTime: Date.now, travelTime: 8111, price: 8000, tip: 2000, requesterFirstName: "John", requesterID: "1309", requesterLastName: "Citrowske", requesterPhone: "636-888-8888", status: "Requested", toSubtitle: "Fort Myers, FL, USA", toTitle: "RSW Departures", requesterFcmToken: "123321", driverPaid: false, platform: "iOS")]
    var body: some View {
        NavigationStack {
            VStack{
                
                RidesPicker(selected: $selected)
                    .padding(.horizontal)
                
                ScrollView{
                    /*(userDetails.driving ?
                     (selected==1 ?
                     driverRideDetails.rides
                     : (selected==2 ?
                     driverRideDetails.prevRides
                     : (selected==3 ?
                     availableRideDetails.rides
                     : unavailableRideDetails.futureRides
                     )
                     )
                     )
                     : (selected==1 ?
                     rideDetails.rides
                     : rideDetails.prevRides), id: \.self)*/ForEach(exampleRides, id: \.self) { ride in
                         NavigationLink{
                             RideDetailView(ride: ride, selected: $selected)
                         }label: {
                             RideCell(ride: ride)
                                 .padding(.horizontal)
                                 .padding(.vertical, 4)
                         }
                         
                     }
                    
                    //PlaceholderView(selected: $selected)
                    
                    Color.clear.frame(height: 1)// So that the refreshable will always work and animations are smooth
                }
                .navigationTitle(userDetails.driving ? "Driver Rides" : "My Rides")
                .navigationDestination(for: Ride.self) { ride in
                    RideDetailView(ride: ride, selected: $selected)
                }
                .refreshable {
                }
                .scrollContentBackground(.hidden)
            }
            .background(Color.theme.backgroundColor)
        }
    }
}


struct RidesView_Previews: PreviewProvider {
    static var previews: some View {
        RidesView()
    }
}
