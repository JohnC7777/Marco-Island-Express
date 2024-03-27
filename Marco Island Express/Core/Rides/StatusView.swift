//
//  StatusView.swift
//  Marco Island Express
//
//  Created by United States MO on 3/25/24.
//

import SwiftUI

struct StatusView: View {
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "plus")
                    .foregroundStyle(Color.theme.accentColor)
                Rectangle()
                    .frame(width: 4, height: 1)
                    .foregroundStyle(Color.theme.accentColor)
                Image(systemName: "person")
                    .foregroundStyle(Color.theme.accentColor)
                Rectangle()
                    .frame(width: 4, height: 1)
                Image(systemName: "car")
                Rectangle()
                    .frame(width: 4, height: 1)
                Image(systemName: "checkmark")
            }
            HStack{
                Text("Status: ")
                    .foregroundStyle(Color.theme.secondaryTextColor)
                Text("Complete")
            }
        }
    }
}

#Preview {
    StatusView()
}
