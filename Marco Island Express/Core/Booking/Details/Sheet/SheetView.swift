//
//  SheetView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/17/24.
//

import SwiftUI

struct SheetView: View {
    
    @EnvironmentObject var vm : RideDetailsViewModel
    @EnvironmentObject var locationVm : LocationSearchViewModel

    var body: some View {
        VStack(alignment:.leading){
            if locationVm.mapState == .confirmingAirport {
                ConfirmAirportDetailsSheet()
            } else {
                DetailsSheetView()
            }
        }
        .padding(.bottom, 15)
        .background{
            UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 10, topTrailing: 10))
                .foregroundStyle(Color.theme.backgroundColor)
        }
    }
}

#Preview {
    SheetView()
        .preferredColorScheme(.dark)
}

