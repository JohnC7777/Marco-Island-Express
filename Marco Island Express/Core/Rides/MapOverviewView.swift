//
//  MapOverviewView.swift
//  Marco Island Express
//
//  Created by United States MO on 3/26/24.
//

import SwiftUI
import MapKit

struct MapOverviewView: View {
    let ride: Ride
    @State private var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.9397, longitude: -81.7075), latitudinalMeters: 20000, longitudinalMeters: 20000))
    @State private var route: MKRoute?
    @State private var loading = true
    var body: some View {
        Map(position: $cameraPosition){
            Marker("Pickup", coordinate: CLLocationCoordinate2D(latitude: ride.fromLat, longitude: ride.fromLon))
                .tint(Color.theme.accentColor)
            Marker("Dropoff", coordinate: CLLocationCoordinate2D(latitude: ride.toLat, longitude: ride.toLon))
                .tint(Color.theme.accentColor)
            if let route {
                MapPolyline(route.polyline)
                    .stroke(Color.theme.accentColor,lineWidth: 4)
            }
        }
        .overlay{
            if loading{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundStyle(Color.theme.accentColor)
            }
        }
        .allowsHitTesting(false)
        .onAppear{
            Task { await searchRoute() }
        }
    }
    func searchRoute() async {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: .init(coordinate: CLLocationCoordinate2D(latitude: ride.fromLat, longitude: ride.fromLon)))
        request.destination = MKMapItem(placemark: .init(coordinate: CLLocationCoordinate2D(latitude: ride.toLat, longitude: ride.toLon)))
        print(request)
        
        Task {
            let result = try? await MKDirections(request: request).calculate()
            route = result?.routes.first
            
            if var rect = route?.polyline.boundingMapRect {

                let wPadding = rect.size.width * 0.25
                let hPadding = rect.size.height * 0.25
                            
                // Add padding to the region
                rect.size.width += wPadding
                rect.size.height += hPadding
                            
                // Center the region on the line
                rect.origin.x -= wPadding / 2
                rect.origin.y -= hPadding / 2

                cameraPosition = .rect(rect)
                loading = false
            }
        }
    }
}
