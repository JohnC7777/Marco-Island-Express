//
//  ReviewOrderView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/27/24.
//

import SwiftUI
import Firebase
import StripePaymentSheet

struct ReviewOrderView: View {
    @StateObject var stripeBackend = StripeModel()
    @EnvironmentObject var vm : LocationSearchViewModel
    @EnvironmentObject var detailsViewModel : RideDetailsViewModel
    @EnvironmentObject var userDetails : UserViewModel
    
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                RideDetailsSubview()
                Divider()
                LocationDetailsSubview()
                Divider()
                TipSubview()
                Divider()
                PricesSummarySubview()
                Spacer()
                
                if let paymentSheet = stripeBackend.paymentSheet {
                    PaymentSheet.PaymentButton(
                        paymentSheet: paymentSheet,
                        onCompletion: stripeBackend.onPaymentCompletion
                    ) {
                        StripeCheckoutButton
                            .padding(.horizontal)
                            .padding(.bottom)
                    }
                } else {
                    StripeCheckoutButton
                        .padding(.horizontal)
                        .padding(.bottom)
                }
            }
            
            if let result = stripeBackend.paymentResult {
                switch result {
                case .completed:
                    Text("Payment complete")
                case .failed(let error):
                    Text("Payment failed: \(error.localizedDescription)")
                case .canceled:
                    Text("Payment canceled.")
                }
            }
        }
        .background{
            Color.theme.backgroundColor
                .ignoresSafeArea()
        }
        .alert(isPresented: $stripeBackend.showError) {
            Alert(title: Text("Error"), message: Text(stripeBackend.errorMessage), dismissButton: .default(Text("OK")))
        }
        .onAppear{
            stripeBackend.preparePaymentSheet(Double((vm.fromLocation?.coordinate.latitude)!), Double((vm.fromLocation?.coordinate.longitude)!), Double((vm.toLocation?.coordinate.latitude)!), Double((vm.toLocation?.coordinate.longitude)!), detailsViewModel.selectedVehicle)
        }
        .onChange(of: stripeBackend.paymentSuccess, {
            if stripeBackend.paymentSuccess == true {
                submitToFirebase()
            }
        })
    }
    
    var StripeCheckoutButton : some View {
        return HStack {
            Spacer()
            Text("Checkout")
            Spacer()
        }
        .fontWeight(.bold)
        .foregroundStyle(.white)
        .padding(.vertical, 12)
        .padding(.horizontal, 35)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.theme.accentColor)
        }
    }
    
    func submitToFirebase(){
        
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("Ride").document()
        ref?.setData([
            "id": "\(ref!.documentID)",
            //"stripePaymentID": addAsAdmin ? "N/A" : "\(uniqueIdentifier)",
            "driverFirstName": "",
            "driverID": "",
            "driverLastName": "",
            "driverPhone": "",
            "fromSubtitle": "\(vm.fromLocation!.subtitle)",
            "fromTitle": "\(vm.fromLocation!.title)",
            "fromLat": vm.fromLocation!.coordinate.latitude,
            "fromLon": vm.fromLocation!.coordinate.longitude,
            "toLat": vm.toLocation!.coordinate.latitude,
            "toLon": vm.toLocation!.coordinate.longitude,
            "notes": /*addAsAdmin ? "Admin Notes: \(notes)" : */"\(detailsViewModel.notes)",
            "paymentMethod": /*addAsAdmin ? "Cash" : */"Card",
            "pickupTime": detailsViewModel.selectedDate,
            "createdTime": Date.now,
            "travelTime": vm.travelTime,
            "price": /*addAsAdmin ? "\(adminCustomPrice*100)" : */"\(vm.price!)",
            //"tip": addAsAdmin ? "" : "\(tipAmount ?? 0.00)",
            "requesterFirstName": /*addAsAdmin ? "\(customerFirstName)" : */"\(userDetails.user!.firstName)",
            "requesterID": /*addAsAdmin ? "N/A" : */"\(Auth.auth().currentUser!.uid)",
            "requesterLastName": /*addAsAdmin ? "\(customerLastName)" : */"\(userDetails.user!.lastName)",
            "requesterPhone": /*addAsAdmin ? "\(customerPhoneNumber)" : */"\(userDetails.user!.phoneNumber)",
            "status": "Requested",
            "toSubtitle": "\(vm.toLocation!.subtitle)",
            "toTitle": "\(vm.toLocation!.title)",
            //"requesterFcmToken": addAsAdmin ? "" : "\(fcmToken ?? "")",
            //"driverPaid": false,
            
            
            ]){ err in
                if let err = err {
                    print("Error writing ride document: \(err)")
                    //isLoading = false
                    //TODO: This is bad. Customer paid but didn't add to firebase
                } else {
                    
                    //Send Notifications to drivers
                    //sendNotification()
                    
                    //Log event to analytics
                    //if let user = userDetails.user{
                    //    Analytics.logEvent("ride_requested", parameters: ["user":"\(user.firstName) \(user.lastName)"])
                    //}
                    
                    //isLoading = false
                    
                    vm.mapState = .noInput
                    //successAlert = true
                    vm.resetSearch()
                }
            }
    }
}

struct ReviewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        let mockViewModel = RideDetailsViewModel()
        return ReviewOrderView()
            .environmentObject(mockViewModel)
    }
}
