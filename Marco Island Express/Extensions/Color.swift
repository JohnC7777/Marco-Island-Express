//
//  Color.swift
//  Marco Island Express
//
//  Created by United States MO on 1/13/24.
//

import SwiftUI

extension Color {
    static var theme = ColorTheme()
}

struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    let primaryTextColor = Color("PrimaryTextColor")
    let secondaryTextColor = Color("SecondaryTextColor")
    let accentColor = Color("AccentColor")
}
