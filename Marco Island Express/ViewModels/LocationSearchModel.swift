//
//  LocationSearchModel.swift
//  Marco Island Express
//
//  Created by United States MO on 1/13/24.
//

import Foundation
import MapKit
import SwiftUI



class LocationSearchViewModel: NSObject, ObservableObject{
    
    @Published var mapState = MapViewState.noInput
    @Published var results = [MKLocalSearchCompletion]()
    @Published var fromResult = MKLocalSearchCompletion()
    @Published var toResult = MKLocalSearchCompletion()
    @Published var fromLocation : Location?
    @Published var toLocation : Location?
    @Published var travelTime : Double?
    @Published var route : MKRoute?
    @Published var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.940666, longitude: -81.701185), latitudinalMeters: 10000, longitudinalMeters: 10000))
    
    private let searchCompleter = MKLocalSearchCompleter()

    @Published var fromQueryFragment: String = ""{
        didSet{
            print("DEBUG: fromQueryFragment changed to -> \(fromQueryFragment)")
            searchCompleter.queryFragment = fromQueryFragment
            print(searchCompleter)
        }
    }
    
    @Published var toQueryFragment: String = ""{
        didSet{
            print("DEBUG: toQueryFragment changed to -> \(toQueryFragment)")
            searchCompleter.queryFragment = toQueryFragment
        }
    }
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = fromQueryFragment
        searchCompleter.region = MKCoordinateRegion(center: .init(latitude: 25.940666, longitude: -81.701185), latitudinalMeters: 500, longitudinalMeters: 500) //setting region to Marco Island
    }
    
    //MARK: Functions
    func selectLocations(_ pickupSearch: MKLocalSearchCompletion,_ dropoffSearch: MKLocalSearchCompletion){
        locationSearch(forLocalSearchCompletion: pickupSearch){response, error in
            self.locationSearch(forLocalSearchCompletion: dropoffSearch){response2, error2 in
                if let error = error, let error2 = error2 {
                    print("DEBUG: Location search failed with error \(error.localizedDescription), \(error2.localizedDescription)")
                    return
                }
                
                guard let item = response?.mapItems.first else{return}
                guard let item2 = response2?.mapItems.first else{return}
                let coordinate = item.placemark.coordinate
                let coordinate2 = item2.placemark.coordinate
                self.fromLocation = Location(title: pickupSearch.title, subtitle: pickupSearch.subtitle, coordinate: coordinate)
                self.toLocation = Location(title: dropoffSearch.title, subtitle: dropoffSearch.subtitle, coordinate: coordinate2)
                
                self.fetchRoute()
                
                /*self.computePrice(self.fromLocation!.coordinate.latitude, self.fromLocation!.coordinate.longitude, self.toLocation!.coordinate.latitude, self.toLocation!.coordinate.longitude){ value in
                    DispatchQueue.main.async {
                        //self.price = value
                        //self.screenDisabled = false
                    }
                }*/
                
            }
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,
                        completion: @escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        searchRequest.region = MKCoordinateRegion(center: .init(latitude: 26.3368, longitude: -81.4380), latitudinalMeters: 5000, longitudinalMeters: 5000)
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    func fetchRoute() {
        let request = MKDirections.Request()
        if let fromLocation = fromLocation, let toLocation = toLocation{
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: fromLocation.coordinate))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: toLocation.coordinate))
            
            Task{
                let result = try? await MKDirections(request: request).calculate()
                DispatchQueue.main.async {
                    self.route = result?.routes.first
                    withAnimation(.snappy){
                        if let rect = self.route?.polyline.boundingMapRect {
                            self.cameraPosition = .rect(rect.moveMapRect())
                            self.mapState = .polylineAdded
                        }
                    }
                }
            }
        }
    }
    
    func resetSearch(){
        results = [MKLocalSearchCompletion]()
        (fromResult,toResult) = (MKLocalSearchCompletion(),MKLocalSearchCompletion())
        (fromQueryFragment,toQueryFragment) = ("","")
        (fromLocation,toLocation,travelTime,route) = (nil, nil, nil, nil)
        cameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.940666, longitude: -81.701185), latitudinalMeters: 10000, longitudinalMeters: 10000))
    }
    
}

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
