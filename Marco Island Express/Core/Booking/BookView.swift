//
//  BookView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/12/24.
//

import SwiftUI
import MapKit

struct BookView: View {
    @StateObject var vm = LocationSearchViewModel()
    @StateObject var detailsViewModel = RideDetailsViewModel()
    @EnvironmentObject var menuData: MenuViewModel
    var body: some View {
        ZStack (alignment: .center){
            MapView()
            if (vm.mapState == .searchingForLocation) {
                SearchView()
            }
            if vm.mapState == .locationSelected || vm.mapState == .polylineAdded {
                SheetView()
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .transition(.move(edge: .bottom))
            }
        }
        .ignoresSafeArea(edges: .bottom)
        .overlay(
            ZStack{
                HStack(alignment: .center, spacing: 0){
                    if !menuData.showDrawer{
                        ActionButton()
                    }
                    if vm.mapState == .noInput {
                        SearchButton()
                    }
                    if vm.mapState == .locationSelected || vm.mapState == .polylineAdded {
                        AddressBar()
                    }
                }
                
            }, alignment: .topLeading
        )
        .environmentObject(vm)
        .environmentObject(detailsViewModel)
    }
}

struct BookView_Previews: PreviewProvider {
    static var previews: some View {
        BookView()
    }
}
