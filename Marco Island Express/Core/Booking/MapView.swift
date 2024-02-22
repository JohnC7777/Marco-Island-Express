//
//  MapView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/13/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var vm : LocationSearchViewModel
    var body: some View {
        Map(position: $vm.cameraPosition){
            
            if vm.mapState == .polylineAdded {
                if let route = vm.route, let fromLocation = vm.fromLocation, let toLocation = vm.toLocation {
                    Marker(fromLocation.title, coordinate: fromLocation.coordinate)
                        .tint(Color.theme.accentColor)
                    Marker(toLocation.title, coordinate: toLocation.coordinate)
                        .tint(Color.theme.accentColor)
                    MapPolyline(route.polyline)
                        .stroke(.blue, lineWidth: 6)
                }
            } else if vm.mapState == .confirmingAirport {
                if let fromLocation = vm.fromLocation{
                    Marker(fromLocation.title, coordinate: fromLocation.coordinate)
                        .tint(Color.theme.accentColor)
                }
            }
        }
    }
}

#Preview {
    MapView()
}
