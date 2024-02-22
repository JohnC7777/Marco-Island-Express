//
//  GradientButton.swift
//  Marco Island Express
//
//  Created by United States MO on 1/11/24.
//

import SwiftUI

struct AccentButton: View {
    var title: String
    var icon: String?
    var onClick: () -> ()
    var body: some View {
        Button(action: onClick, label: {
            HStack(spacing: 15){
                Spacer()
                Text(title)
                if let icon = icon{ Image(systemName: icon) }
                Spacer()
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 35)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.theme.accentColor)
            }
            
        })
    }
}
