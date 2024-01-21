//
//  LocationSearchResultCell.swift
//  Marco Island Express
//
//  Created by United States MO on 1/13/24.
//

import SwiftUI

struct LocationSearchResultCell: View {
    let title : String
    let subtitle : String
    var body: some View {
        HStack{
            Image(systemName: "mappin.circle.fill")
                .resizable()
                .foregroundStyle(Color.theme.accentColor)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4){
                Text(title)
                    .font(.body)
                    .foregroundStyle(Color.theme.primaryTextColor)
                
                Text(subtitle)
                    .font(.system(size: 15))
                    .foregroundStyle(Color.theme.secondaryTextColor)
                
                Divider()
            }
            .padding(.leading, 8)
            .padding(.vertical, 8)
        }
        .padding(.leading)
    }
}

#Preview {
    LocationSearchResultCell(title: "Marco Island Express", subtitle: "123 Marco island way, marco island, FL, 63202")
}
