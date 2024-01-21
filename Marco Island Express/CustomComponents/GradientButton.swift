//
//  GradientButton.swift
//  Marco Island Express
//
//  Created by United States MO on 1/11/24.
//

import SwiftUI

struct GradientButton: View {
    var title: String
    var icon: String
    var onClick: () -> ()
    var body: some View {
        Button(action: onClick, label: {
            HStack(spacing: 15){
                Spacer()
                Text(title)
                Image(systemName: icon)
                Spacer()
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .padding(.vertical, 12)
            .padding(.horizontal, 35)
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.linearGradient(colors: [Color.theme.accentColor, .green], startPoint: .top, endPoint: .bottom))
            }
            
        })
    }
}
