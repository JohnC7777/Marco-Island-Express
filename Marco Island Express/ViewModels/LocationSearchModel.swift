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
    
    //MARK: Variables
    
    @Published var mapState = MapViewState.noInput
    @Published var results = [MKLocalSearchCompletion]()
    @Published var fromResult = MKLocalSearchCompletion()
    @Published var toResult = MKLocalSearchCompletion()
    @Published var fromLocation : Location?
    @Published var toLocation : Location?
    @Published var travelTime : Double?
    @Published var route : MKRoute?
    @Published var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.940666, longitude: -81.701185), latitudinalMeters: 10000, longitudinalMeters: 10000))
    @Published var showingInvalidAlert : Bool = false
    @Published var price : Double?
    
    private let searchCompleter = MKLocalSearchCompleter()

    @Published var fromQueryFragment: String = ""{
        didSet{
            searchCompleter.queryFragment = fromQueryFragment
        }
    }
    
    @Published var toQueryFragment: String = ""{
        didSet{
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
    
    //Get location details on both of the selected searches
    func configureSearchResultsFor(_ pickupSearch: MKLocalSearchCompletion,_ dropoffSearch: MKLocalSearchCompletion){
        locationSearch(forLocalSearchCompletion: pickupSearch){response, error in
            self.locationSearch(forLocalSearchCompletion: dropoffSearch){ response2, error2 in
                if let error = error, let error2 = error2 {
                    print("DEBUG: Location search failed with error \(error.localizedDescription), \(error2.localizedDescription)")
                    return
                }
                
                //Set variables to results
                guard let pickupMapItem = response?.mapItems.first, let dropoffMapItem = response2?.mapItems.first else{return}
                self.fromLocation = Location(title: pickupSearch.title, subtitle: pickupSearch.subtitle, coordinate: pickupMapItem.placemark.coordinate, isAirport: response?.mapItems.first?.pointOfInterestCategory == MKPointOfInterestCategory(rawValue: "MKPOICategoryAirport"))
                self.toLocation = Location(title: dropoffSearch.title, subtitle: dropoffSearch.subtitle, coordinate: dropoffMapItem.placemark.coordinate, isAirport: response2?.mapItems.first?.pointOfInterestCategory == MKPointOfInterestCategory(rawValue: "MKPOICategoryAirport"))
                
                print(self.fromLocation)
                
                
                self.computePrice { price in
                    DispatchQueue.main.async {
                        self.price = price //TODO: price is different for other car types. 
                    }
                }
                //Change screen to airport confirmation or details screen
                withAnimation{
                    if self.fromLocation!.isAirport {
                        self.mapState = .confirmingAirport
                        self.cameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (self.fromLocation?.coordinate.latitude)!, longitude: (self.fromLocation?.coordinate.longitude)!), latitudinalMeters: 500, longitudinalMeters: 500))
                    } else {
                        self.mapState = .locationConfirmed
                        self.fetchRoute()
                    }
                }
            }
        }
    }
    
    //Get location details for a specific search
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,
                        completion: @escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        searchRequest.region = MKCoordinateRegion(center: .init(latitude: 26.3368, longitude: -81.4380), latitudinalMeters: 5000, longitudinalMeters: 5000)
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    
    //Fetch the route for the two locations
    func fetchRoute() {
        let request = MKDirections.Request()
        if let fromLocation = fromLocation, let toLocation = toLocation{
            request.source = MKMapItem(placemark: MKPlacemark(coordinate: fromLocation.coordinate))
            request.destination = MKMapItem(placemark: MKPlacemark(coordinate: toLocation.coordinate))
            
            Task{
                let result = try? await MKDirections(request: request).calculate()
                DispatchQueue.main.async {
                    self.route = result?.routes.first
                    self.travelTime = result?.routes.first?.expectedTravelTime
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
    
    func computePrice(completion: @escaping (Double?) -> Void){
        let url = URL(string:"https://marco-island-express.glitch.me/calculate-price")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("fromLat: \(self.fromLocation!.coordinate.latitude)    fromLon: \(self.fromLocation!.coordinate.longitude)   toLat: \(self.toLocation!.coordinate.latitude)    toLon: \(self.toLocation!.coordinate.longitude)")
        let body = [
            "from": [
                "latitude": self.fromLocation!.coordinate.latitude,
                "longitude": self.fromLocation!.coordinate.longitude
            ],
            "to": [
                "latitude": self.toLocation!.coordinate.latitude,
                "longitude": self.toLocation!.coordinate.longitude
            ]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request){ data, response, error in
            guard let data = data, error == nil,
                  (response as? HTTPURLResponse)?.statusCode == 200
            else{
                completion(nil)
                return
            }
            
            //Decode JSON response
            do {
                let decoder = JSONDecoder()
                let response1 = try decoder.decode(PriceResponse.self, from: data)
                completion(response1.priceSedan)
            } catch {
                DispatchQueue.main.async {
                    self.showingInvalidAlert = true
                }
                print("THE ERROR IS \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
    //Reset search variables
    func resetSearch(){
        results = [MKLocalSearchCompletion]()
        (fromResult,toResult) = (MKLocalSearchCompletion(),MKLocalSearchCompletion())
        (fromQueryFragment,toQueryFragment) = ("","")
        (fromLocation,toLocation,travelTime,route) = (nil, nil, nil, nil)
        cameraPosition = .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.940666, longitude: -81.701185), latitudinalMeters: 10000, longitudinalMeters: 10000))
    }
    
}

//MARK: Extensions

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate{
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
