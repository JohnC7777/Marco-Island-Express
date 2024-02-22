//
//  RootView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/11/24.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @Binding var userIsLoggedIn : Bool
    @StateObject var menuData = MenuViewModel()
    @StateObject var userData = UserViewModel()
    @Namespace var animation
    
    var body: some View {
        
        ZStack(alignment:.leading){
            TabView(selection: $menuData.selectedMenu){
                BookView()
                    .tag("Book")
                
                RidesView()
                    .tag("Rides")
                
                SettingsView()
                    .tag("Settings")
            }
            if menuData.showDrawer {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation{
                            menuData.showDrawer.toggle()
                        }
                    }
            }
            if menuData.showDrawer{
                Drawer(animation: animation, userIsLoggedIn: $userIsLoggedIn)
            }

        }
        //.frame(width: UIScreen.main.bounds.width)
        //.offset(x: userIsLoggedIn ? menuData.showDrawer ? 125 : -125 : 0)
        .environmentObject(menuData)
        .environmentObject(userData)
        .alert("Cannot retrieve user data. Try logging in again", isPresented: $userData.showMissingUserError) {
            Button("OK") {
                do {
                    Analytics.logEvent("Error_Retrieving_User_Details", parameters:["ID": Auth.auth().currentUser?.uid ?? "Id is Nil"])
                    try Auth.auth().signOut()
                    fatalError()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
