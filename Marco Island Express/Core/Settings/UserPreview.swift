//
//  UserPreview.swift
//  Marco Island Express
//
//  Created by United States MO on 3/25/24.
//

import SwiftUI

struct UserPreview: View {
    var body: some View {
        HStack{
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundStyle(Color.theme.backgroundColor)
                .padding(15)
                .background(Color.theme.accentColor)
                .clipShape(Circle())
            
            VStack(alignment:.leading){
                Text("First Last")
                    .font(.headline)
                Text(verbatim: "test@gmail.com")
                    .font(.subheadline)
                    .foregroundStyle(Color.theme.secondaryTextColor)
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    UserPreview()
}
