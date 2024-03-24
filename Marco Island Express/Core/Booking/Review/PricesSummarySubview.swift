//
//  PricesSummarySubview.swift
//  Marco Island Express
//
//  Created by United States MO on 1/27/24.
//

import SwiftUI

struct PricesSummarySubview: View {
    @EnvironmentObject var vm : RideDetailsViewModel
    var body: some View {
        VStack{
            PriceNameAndAmountView(name: "Ride Fee", amount: 80.00)
            PriceNameAndAmountView(name: "Tip Amount", amount: vm.tipAmount ?? 0.0)
            PriceNameAndAmountView(name: "Credit Card Fee", amount: 3.00)
            PriceNameAndAmountView(name: "Sales Tax", amount: 8.00)
            Divider()
            PriceNameAndAmountView(name: "Total Amount", amount: 117.00)
        }
        .padding(.horizontal)
    }
}

struct PriceNameAndAmountView: View{
    let name : String
    let amount : Double
    var body: some View {
        HStack{
            Text(name)
                .foregroundStyle(Color.theme.secondaryTextColor)
            Spacer()
            Text(amount.formatPrice())
                .foregroundStyle(Color.theme.primaryTextColor)
        }
    }
}
