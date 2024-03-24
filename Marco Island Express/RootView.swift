//
//  HomeView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/13/24.
//

import SwiftUI
import Firebase

struct RootView: View {
    @State private var userIsLoggedIn = false
    var body: some View {
        VStack{
            if userIsLoggedIn{
                HomeView(userIsLoggedIn: $userIsLoggedIn)
            }else{
                LoginView(userIsLoggedIn: $userIsLoggedIn)
            }
        }
        .onAppear{
            Auth.auth().addStateDidChangeListener() { auth, user in
                if user != nil {
                    withAnimation{
                        userIsLoggedIn = true
                    }
                }
            }
        }
    }
}

#Preview {
    RootView()
}
