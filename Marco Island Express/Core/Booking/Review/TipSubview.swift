//
//  TipSubview.swift
//  Marco Island Express
//
//  Created by United States MO on 1/27/24.
//

import SwiftUI

struct TipSubview: View {
    @EnvironmentObject var vm : RideDetailsViewModel
    var body: some View {
        VStack{
            HStack{
                Text("Tip Amount")
                    .foregroundStyle(Color.theme.secondaryTextColor)
                Spacer()
                Text(vm.tipAmount?.formatPrice() ?? "$0")
                    .foregroundStyle(Color.theme.primaryTextColor)
            }
            //Picker
            TipPicker()
        }
        .padding(.horizontal)
    }
}

