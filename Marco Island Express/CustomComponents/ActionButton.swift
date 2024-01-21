//
//  ActionButton.swift
//  Marco Island Express
//
//  Created by United States MO on 1/13/24.
//

import SwiftUI

struct ActionButton: View {
    @EnvironmentObject var menuData: MenuViewModel
    @EnvironmentObject var vm : LocationSearchViewModel
    var body: some View {
        Image(systemName: (vm.mapState == .noInput) ? "line.3.horizontal" : "arrow.left")
            .font(.system(size: vm.mapState == .searchingForLocation ? 20 : 25))
            .padding()
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)){
                    switch vm.mapState {
                    case .noInput:
                        menuData.showDrawer.toggle()
                    case .searchingForLocation:
                        vm.resetSearch()
                        vm.mapState = .noInput
                    case .locationSelected, .polylineAdded:
                        vm.mapState = .searchingForLocation
                    }
                }
            }
            .background{
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(Color.theme.secondaryBackgroundColor)
                    .shadow(color: Color.theme.backgroundColor, radius: 2)
                
            }
            .padding(.leading, 5)
    }
}

#Preview {
    HomeView(userIsLoggedIn: .constant(true))
}
