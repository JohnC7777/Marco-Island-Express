//
//  AddressBar.swift
//  Marco Island Express
//
//  Created by United States MO on 1/17/24.
//

import SwiftUI

struct AddressBar: View {
    @FocusState.Binding var focusedField: SearchField?
    @Binding var whereIsUser: SearchUserState?
    @EnvironmentObject var vm : LocationSearchViewModel
    var body: some View {
        HStack(alignment:.center){
            Spacer()
            Text("\(vm.fromLocation?.title ?? "")")
                .lineLimit(1)
                .onTapGesture {
                    print("Set to from")
                    vm.mapState = .searchingForLocation
                    focusedField = .from
                    whereIsUser = .from
                }
            Spacer()
            Image(systemName: "arrow.right")
                .foregroundStyle(Color.theme.secondaryTextColor)
            Spacer()
            Text("\(vm.toLocation?.title ?? "")")
                .lineLimit(1)
                .onTapGesture {
                    print("Set to to")
                    vm.mapState = .searchingForLocation
                    focusedField = .to
                    whereIsUser = .to
                    //print(focusedField!)
                }
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

struct AddressBar_Previews: PreviewProvider {
    @FocusState static var focusedField: SearchField?
    @State static var whereIsUser: SearchUserState? = nil

    static var previews: some View {
        let mockViewModel = LocationSearchViewModel()
        return AddressBar(
            focusedField: $focusedField,
            whereIsUser: $whereIsUser
        )
        .environmentObject(mockViewModel)
    }
}
