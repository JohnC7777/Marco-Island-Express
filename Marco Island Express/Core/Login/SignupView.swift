//
//  SignupView.swift
//  Marco Island Express
//
//  Created by United States MO on 1/11/24.
//

import SwiftUI
import Firebase

struct SignupView: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            
            Spacer(minLength: 0)
            
            Text("Signup")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.primaryTextColor)
            
            Text("Please register for an account")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(Color.theme.secondaryTextColor)
                .padding(.top, -5)
            
            VStack(spacing: 25){
                
                CustomTextField(sfIcon: "person", hint: "First Name", value: $firstName)
                
                CustomTextField(sfIcon: "person", hint: "Last Name", value: $lastName)
                
                CustomTextField(sfIcon: "phone", hint: "Phone", value: $phoneNumber, keyboardType: .phonePad)
                
                CustomTextField(sfIcon: "at", hint: "Email", value: $email, keyboardType: .emailAddress, capitalization: .never)
                
                CustomTextField(sfIcon: "lock", hint: "Password", isPassword: true, value: $password, capitalization: .never)
                    .padding(.top, 5)
                
                CustomTextField(sfIcon: "lock", hint: "Confirm Password", isPassword: true, value: $confirmPassword, capitalization: .never)
                    .padding(.top, 5)
                
            }
            .padding(.top, 20)
            
            GradientButton(title: "Register", icon: "arrow.right"){
                registerUser()
            }
            
            Spacer(minLength: 0)
            
        }
        .padding(.horizontal)
        .alert("\(errorMessage)", isPresented: $showError) {
            Button("OK") {errorMessage = ""}
        }
    }
    
    func registerUser(){
        //TODO: validation for all inputs
        if areInputsValid() {
            let db = Firestore.firestore()
            Auth.auth().createUser(withEmail: email, password: password){ result, error in
                if error != nil{
                    print(error!.localizedDescription)
                    errorMessage = error!.localizedDescription
                    showError = true
                }else{
                    db.collection("User").document("\(Auth.auth().currentUser!.uid)").setData([
                        "id": "\(Auth.auth().currentUser!.uid)",
                        "firstName": "\(firstName)",
                        "lastName": "\(lastName)",
                        "phoneNumber": "\(phoneNumber)",
                        "newRideNotifications": false,
                        "fcmToken": "",
                        "role": "customer"
                    ])
                    print("Document successfully written!")
                }
            }
        } else{
            //Show error message
            showError = true
        }
    }
    
    func areInputsValid() -> Bool {
        
        //Check First Name not empty
        if (firstName == ""){
            errorMessage = "First name cannot be empty"
            return false
        }
        
        //Check Last Name not empty
        if (lastName == ""){
            errorMessage = "Last name cannot be empty"
            return false
        }
        
        //Check Phone Number length
        let digits = phoneNumber.filter { $0.isNumber }
        if (digits.count != 10) && (digits.count != 7){
            errorMessage = "Phone number must be 7 or 10 digits long"
            return false
        }
        
        //Check passwords match
        if(password != confirmPassword){
            errorMessage = "Passwords must match"
            return false
        }
        
        return true
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
            .preferredColorScheme(.dark)
    }
}
