//
//  MenuButton.swift
//  Marco Island Express
//
//  Created by United States MO on 1/12/24.
//

import SwiftUI
import Firebase

struct MenuButton: View {
    var name: String
    var image: String
    @Binding var selectedMenu : String
    var animation : Namespace.ID
    @Binding var userIsLoggedIn : Bool
    var body: some View {
        Button(action: {
            if name == "Logout"{
                print("Attempting logout")
                do {
                    try Auth.auth().signOut()
                    withAnimation{
                        userIsLoggedIn = false
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }else{
                withAnimation(.spring()){
                    selectedMenu = name
                }
            }
        }, label: {
            HStack(spacing: 15){
                
                Image(systemName: image)
                    .font(.title2)
                    .foregroundColor(selectedMenu == name ? Color.theme.primaryTextColor : Color.theme.secondaryTextColor)
                
                Text(name)
                    .foregroundColor(selectedMenu == name ? Color.theme.primaryTextColor : Color.theme.secondaryTextColor)
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .frame(width: 200, alignment: .leading)
            .background(
                ZStack{
                    if selectedMenu == name {
                        Color.theme.accentColor
                            .cornerRadius(10)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                    }else{
                        Color.clear
                    }
                }
            )
            .cornerRadius(10)
        })
    }
}

struct MenuButton_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
