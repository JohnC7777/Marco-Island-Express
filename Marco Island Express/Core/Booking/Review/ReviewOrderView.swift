//
//  ReviewOrderView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/27/24.
//

import SwiftUI

struct ReviewOrderView: View {
    var body: some View {
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
            AccentButton(title:"Checkout"){
                
            }
            .padding(.bottom)
            .padding(.horizontal)
        }
        .background{
            Color.theme.backgroundColor
                .ignoresSafeArea()
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
