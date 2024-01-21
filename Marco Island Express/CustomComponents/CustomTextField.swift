//
//  CustomTextField.swift
//  Marco Island Express
//
//  Created by United States MO on 1/11/24.
//

import SwiftUI

struct CustomTextField: View {
    var sfIcon: String
    var iconTint: Color = Color.theme.secondaryTextColor
    var hint: String
    var isPassword: Bool = false
    @Binding var value: String
    @State private var showPassword: Bool = false
    var keyboardType: UIKeyboardType = .default
    var capitalization: TextInputAutocapitalization = .sentences
    var body: some View {
        HStack(alignment: .top, spacing: 8){
            Image(systemName: sfIcon)
                .foregroundStyle(iconTint)
                .frame(width: 30)
                .offset(y: 2)
            
            VStack(alignment: .leading, spacing: 8){
                if isPassword {
                    Group{
                        if showPassword {
                            TextField(hint, text: $value)
                                .keyboardType(keyboardType)
                                .textInputAutocapitalization(capitalization)
                        } else {
                            SecureField(hint, text: $value)
                                .keyboardType(keyboardType)
                                .textInputAutocapitalization(capitalization)
                        }
                    }
                } else {
                    TextField(hint, text: $value)
                        .keyboardType(keyboardType)
                        .textInputAutocapitalization(capitalization)
                }
                
                Divider()
            }
            .overlay(alignment: .trailing){
                if isPassword{
                    Button(action: {
                        withAnimation {
                            showPassword.toggle()
                        }
                    }, label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundStyle(Color.theme.secondaryTextColor)
                            .padding(10)
                    })
                }
            }
            
        }
    }
}
