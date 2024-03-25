//
//  RidesPicker.swift
//  Marco Island Express
//
//  Created by United States MO on 3/24/24.
//

import SwiftUI

struct RidesPicker: View {
    
    @Binding var selected : Int
    @Namespace private var animation
    @EnvironmentObject var userDetails : UserViewModel
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        HStack{
            HStack{
                Option(thisOption: 1, name: "UPCOMING", selected: $selected, animation: animation)
                Option(thisOption: 2, name: "COMPLETED", selected: $selected, animation: animation)
                
                if userDetails.driving {
                    Option(thisOption: 3, name: "AVAILABLE", selected: $selected, animation: animation)
                }
                if let user = userDetails.user {
                    if userDetails.driving && user.role == "admin" {
                        Option(thisOption: 4, name: "UNAVAILABLE", selected: $selected, animation: animation)
                    }
                }
            }
            .padding(5)
            .background{
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .foregroundColor(colorScheme == .dark ? Color(.systemGray5) : .white)
                    .shadow(radius: 2)
            }
        }
        .lineLimit(1)
        .minimumScaleFactor(0.5)
    }
}

struct Option: View {
    let thisOption: Int
    let name: String
    @Binding var selected: Int
    @Environment(\.colorScheme) var colorScheme
    let animation : Namespace.ID
    var body: some View {
        Text(name)
            .fontWeight(.semibold)
            .foregroundColor(selected == thisOption ? .white : (colorScheme == .dark ? Color(.systemGray2) : .black))
            .opacity(selected == thisOption ? 1 : 0.7)
            .padding(.vertical, 12)
            .frame(maxWidth: .infinity)
            .background{
                if selected == thisOption {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color.theme.accentColor)
                        .matchedGeometryEffect(id: "OPTION", in: animation)
                        .shadow(radius: 2)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture{
                withAnimation{selected = thisOption}
            }
    }
}

