//
//  MenuButton.swift
//  Marco Island Express
//
//  Created by United States MO on 1/12/24.
//

import SwiftUI
import Firebase

struct SettingsButton: View {
    var name: String
    var image: String
    let chevron: Bool
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            HStack(spacing: 15){
                
                Image(systemName: image)
                    .font(.title2)
                    .foregroundStyle(Color.theme.primaryTextColor)
                
                Text(name)
                    .foregroundStyle(Color.theme.primaryTextColor)
                
                Spacer()
                
                if chevron{Image(systemName: "chevron.right")}
            }
            .padding(.horizontal)
            .padding(.vertical, 12)
            .cornerRadius(10)
        }
    }
}
