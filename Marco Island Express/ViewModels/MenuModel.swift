//
//  MenuModel.swift
//  Marco Island Express
//
//  Created by United States MO on 1/12/24.
//

import SwiftUI

class MenuViewModel: ObservableObject {
    
    @Published var selectedMenu = "Book"
    
    @Published var showDrawer = false
}
