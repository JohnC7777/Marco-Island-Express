//
//  MapView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/13/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.3346, longitude: -122.0090), latitudinalMeters: 10000, longitudinalMeters: 10000))
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
            }
        }
    }
}

#Preview {
    MapView()
}
