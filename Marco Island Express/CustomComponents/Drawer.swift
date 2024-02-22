//
//  Drawer.swift
//  Marco Island Express
//
//  Created by United States MO on 1/12/24.
//

import SwiftUI
import Firebase

struct Drawer: View {
    @EnvironmentObject var menuData: MenuViewModel
    @EnvironmentObject var userData: UserViewModel
    var animation : Namespace.ID
    @Binding var userIsLoggedIn: Bool
    
    var body: some View {
        VStack{
            HStack{
                Image("TestProfilePic")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                
                Spacer()
                
                if menuData.showDrawer {
                    Image(systemName: "xmark")
                        .padding()
                        .font(.system(size: 25))
                        .foregroundStyle(Color.theme.primaryTextColor)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)){
                                menuData.showDrawer.toggle()
                            }
                        }
                }
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 10){
                Text("Hello,")
                    .font(.title2)
                
                Text("\(userData.user?.firstName ?? "Loading") \(userData.user?.lastName ?? "")")
                    .font(.title)
                    .fontWeight(.heavy)
            }
            .foregroundColor(Color.theme.primaryTextColor)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 5)
            
            //Menu Buttons
            VStack(spacing: 15){
                MenuButton(name: "Book", image: "map", selectedMenu: $menuData.selectedMenu, animation: animation, userIsLoggedIn: $userIsLoggedIn)
                
                MenuButton(name: "Rides", image: "car", selectedMenu: $menuData.selectedMenu, animation: animation, userIsLoggedIn: $userIsLoggedIn )
                
                MenuButton(name: "Settings", image: "gear", selectedMenu: $menuData.selectedMenu, animation: animation, userIsLoggedIn: $userIsLoggedIn)
            }
            .frame(width: 250, alignment: .leading)
            .padding(.top, 30)
            .padding(.leading)
            
            Divider()
                .background(Color.theme.primaryTextColor)
                .padding(.top, 30)
                .padding(.horizontal)
            
            Spacer()
            MenuButton(name: "Logout", image: "rectangle.righthalf.inset.fill.arrow.right", selectedMenu: .constant(""), animation: animation, userIsLoggedIn: $userIsLoggedIn)
                .onTapGesture {
                    print("Attempting logout")
                    do {
                        try Auth.auth().signOut()
                        withAnimation{
                            userIsLoggedIn = false
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
        }
        .frame(width: 250)
        .background(
            Color(Color.theme.backgroundColor)
                .ignoresSafeArea(.all, edges: .vertical)
        )
        .animation(.easeInOut)
        .transition(.move(edge: .leading))
    }
}

struct Drawer_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
