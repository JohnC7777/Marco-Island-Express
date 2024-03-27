//
//  SettingsView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/12/24.
//

import SwiftUI
import Firebase

struct SettingsView: View {
    @EnvironmentObject var vm : UserViewModel
    @Binding var userIsLoggedIn : Bool
    var body: some View {
        VStack{
            
            UserPreview()
                .padding(.vertical,4)
            
            ZStack{
                UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 10, topTrailing: 10))
                    .foregroundStyle(Color.theme.secondaryBackgroundColor)
                VStack{
                    SettingsButton(name: "Personal Information", image: "person", chevron: true){}
                    SettingsButton(name: "Notifications", image: "bell", chevron: true){}
                    SettingsButton(name: "Settings", image: "gear", chevron: true){}
                    Divider()
                    SettingsButton(name: "Help & Support", image: "rectangle.and.pencil.and.ellipsis", chevron: true){}
                    SettingsButton(name: "Terms & Conditions", image: "doc.text", chevron: true){}
                    SettingsButton(name: "Give us Feedback", image: "highlighter", chevron: true){}
                    Button(action: {}
                           , label: {
                        HStack(spacing: 15){
                            
                            Image(systemName: "car")
                                .font(.title2)
                                .foregroundStyle(Color.theme.primaryTextColor)
                            
                            Text("Driver View")
                                .foregroundStyle(Color.theme.primaryTextColor)
                            
                            Spacer()
                            
                            Toggle(isOn: .constant(true), label: {})
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 12)
                        .cornerRadius(10)
                    })
                    Spacer()
                    Divider()
                    SettingsButton(name:"Logout", image:"rectangle.righthalf.inset.fill.arrow.right", chevron: false){
                        vm.logout()
                        withAnimation{
                            userIsLoggedIn = false
                        }
                    }
                }
                .padding(.top)
            }
        }
        .background(Color.theme.backgroundColor)
    }
}

