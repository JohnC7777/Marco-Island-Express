//
//  LoginView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/11/24.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showSignup = false
    @Binding var userIsLoggedIn : Bool
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 15){
                
                Spacer(minLength: 0)
                
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.theme.primaryTextColor)
                
                Text("Please sign in to continue")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.theme.secondaryTextColor)
                    .padding(.top, -5)
                
                VStack(spacing: 25){
                    CustomTextField(sfIcon: "at", hint: "Email", value: $email, keyboardType: .emailAddress, capitalization: .never)
                    
                    
                    CustomTextField(sfIcon: "lock", hint: "Password", isPassword: true, value: $password)
                        .padding(.top, 5)
                    
                }
                .padding(.top, 20)
                
                AccentButton(title: "Login", icon: "arrow.right"){
                    login()
                }
                
                Text("Forgot Password? Reset")
                    .foregroundStyle(Color.theme.accentColor)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .onTapGesture {
                        print("TODO: open password reset screen")
                    }
                
                Spacer(minLength: 0)
                
                Text("Don't have an account? \(Text("Signup").foregroundColor(Color.theme.accentColor))")
                
                .onTapGesture {
                    showSignup.toggle()
                }
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .center)
                
                
            }
            .padding(.horizontal)
            .navigationDestination(isPresented: $showSignup){
                SignupView()
            }
        }
    }
    
    func login(){
        Auth.auth().signIn(withEmail: email, password: password){ result, error in
            if error != nil {
                print(error!.localizedDescription)
            }else{
                print("User is now signed in!")
                withAnimation{
                    userIsLoggedIn = true
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(userIsLoggedIn: .constant(false))
            .preferredColorScheme(.light)
    }
}
