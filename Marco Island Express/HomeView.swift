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
    @StateObject var userData = UserViewModel()
    
    var body: some View {
        
        ZStack(alignment:.leading){
            TabView(selection: .constant("Book")){
                BookView()
                    .tabItem{
                        Image(systemName: "map")
                        Text("Book")
                    }
                
                RidesView()
                    .tabItem{
                        Image(systemName: "car")
                        Text("Rides")
                    }
                
                SettingsView()
                    .tabItem{
                        Image(systemName: "gear")
                        Text("Settings")
                    }
            }
        }
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
