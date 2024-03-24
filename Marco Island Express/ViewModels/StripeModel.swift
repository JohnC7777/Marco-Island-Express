//
//  BackendModel.swift
//  Marco Island Express
//
//  Created by United States MO on 3/9/24.
//

import StripePaymentSheet
import SwiftUI

class StripeModel: ObservableObject {
    let backendCheckoutUrl = URL(string: "https://marco-island-express.glitch.me/create-payment-intent")! // Your backend endpoint
    @Published var paymentSheet: PaymentSheet?
    @Published var paymentResult: PaymentSheetResult?
    @Published var showError = false
    @Published var paymentSuccess = false
    @Published var errorMessage = ""
    
    
    func preparePaymentSheet(_ fromLat : Double,_ fromLon : Double,_ toLat : Double,_ toLon : Double,_ selectedOption : VehicleType) {
        // MARK: Fetch the PaymentIntent and Customer information from the backend
        var request = URLRequest(url: backendCheckoutUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Set content type to JSON
        let body = [
            "from": [
                "latitude": fromLat,
                "longitude": fromLon
            ],
            "to": [
                "latitude": toLat,
                "longitude": toLon
            ],
            "selectedOption": selectedOption.rawValue
        ] as [String : Any]
        let jsonData = try? JSONSerialization.data(withJSONObject: body)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                  let paymentIntentClientSecret = json["paymentIntent"] as? String,
                  let publishableKey = json["publishableKey"] as? String,
                  let self = self else {
                print("we had an error \(error?.localizedDescription ?? "")")
                // Handle error
                return
            }
            
            STPAPIClient.shared.publishableKey = publishableKey
            // MARK: Create a PaymentSheet instance
            var configuration = PaymentSheet.Configuration()
            configuration.merchantDisplayName = "Marco Island Express"
            configuration.allowsDelayedPaymentMethods = false
            
            DispatchQueue.main.async {
                self.paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentIntentClientSecret, configuration: configuration)
            }
        })
        task.resume()
    }
    
    func onPaymentCompletion(result: PaymentSheetResult) {
        self.paymentResult = result
        switch result {
        case .failed(let error):
            errorMessage = error.localizedDescription
            showError = true
        case .completed:
            paymentSuccess = true
        default:
            break
        }
    }
}
