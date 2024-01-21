//
//  AddressBar.swift
//  Marco Island Express
//
//  Created by United States MO on 1/17/24.
//

import SwiftUI

struct AddressBar: View {
    @EnvironmentObject var vm : LocationSearchViewModel
    var body: some View {
        HStack(alignment:.center){
            Spacer()
            Text("\(vm.fromLocation?.title ?? "")")
                .lineLimit(1)
            Spacer()
            Image(systemName: "arrow.right")
                .foregroundStyle(Color.theme.secondaryTextColor)
            Spacer()
            Text("\(vm.toLocation?.title ?? "")")
                .lineLimit(1)
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
    }
}

#Preview {
    AddressBar()
}
