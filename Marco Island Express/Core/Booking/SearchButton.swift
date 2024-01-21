//
//  SearchButton.swift
//  Marco Island Express
//
//  Created by United States MO on 1/13/24.
//

import SwiftUI

struct SearchButton: View {
    @EnvironmentObject var vm : LocationSearchViewModel
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
            Text("Where to?")
            Spacer()
        }
        .foregroundStyle(Color.theme.primaryTextColor)
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 100)
                .foregroundStyle(Color.theme.secondaryBackgroundColor)
                .shadow(color:Color.theme.backgroundColor,radius: 2)
        }
        .padding(.trailing)
        .padding(.leading, 5)
        .onTapGesture {
            withAnimation{
                vm.mapState = .searchingForLocation
            }
        }
    }
}

#Preview {
    SearchButton()
}
