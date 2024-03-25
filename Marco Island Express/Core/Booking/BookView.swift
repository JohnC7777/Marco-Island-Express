//
//  BookView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/12/24.
//

import SwiftUI
import MapKit

struct BookView: View {
    @FocusState private var focusedField: SearchField?
    @State private var whereIsUser: SearchUserState?
    @StateObject var vm = LocationSearchViewModel()
    @StateObject var detailsViewModel = RideDetailsViewModel()
    var body: some View {
        ZStack (alignment: .center){
            MapView()
            if (vm.mapState == .searchingForLocation) {
                SearchView(focusedField: $focusedField, whereIsUser: $whereIsUser)
            }
            if vm.mapState == .locationConfirmed || vm.mapState == .polylineAdded || vm.mapState == .confirmingAirport{
                SheetView()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .transition(.move(edge: .bottom))
            }
            if vm.mapState == .review {
                ReviewOrderView()
            }
            
        }
        .alert("Sorry we do not currently drive the selected route. Contact us to get a quote.",isPresented: $vm.showingInvalidAlert){
            Button("OK", role: .cancel) {
                vm.price = nil
                vm.toLocation = nil
                vm.fromLocation = nil
                vm.mapState = .searchingForLocation
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .overlay(
            ZStack{
                HStack(alignment: .center, spacing: 0){
                    if vm.mapState != .noInput {
                        ActionButton()
                    }
                    if vm.mapState == .noInput {
                        SearchButton(focusedField: $focusedField, whereIsUser: $whereIsUser)
                    }
                    if vm.mapState == .locationConfirmed || vm.mapState == .polylineAdded {
                        AddressBar(focusedField: $focusedField, whereIsUser: $whereIsUser)
                    }
                }
                
            }, alignment: .topLeading
        )
        .toolbar(vm.mapState == .noInput ? .visible : .hidden, for: .tabBar)
        .environmentObject(vm)
        .environmentObject(detailsViewModel)
    }
}
