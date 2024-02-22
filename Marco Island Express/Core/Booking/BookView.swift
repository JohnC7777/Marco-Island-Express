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
    @EnvironmentObject var menuData: MenuViewModel
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
        .ignoresSafeArea(edges: .bottom)
        .overlay(
            ZStack{
                HStack(alignment: .center, spacing: 0){
                    ActionButton()
                    if vm.mapState == .noInput {
                        SearchButton(focusedField: $focusedField, whereIsUser: $whereIsUser)
                    }
                    if vm.mapState == .locationConfirmed || vm.mapState == .polylineAdded {
                        AddressBar(focusedField: $focusedField, whereIsUser: $whereIsUser)
                    }
                }
                
            }, alignment: .topLeading
        )
        .environmentObject(vm)
        .environmentObject(detailsViewModel)
    }
}
