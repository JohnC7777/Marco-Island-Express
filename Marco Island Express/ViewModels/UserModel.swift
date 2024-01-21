//
//  UserModel.swift
//  Marco Island Express
//
//  Created by United States MO on 1/13/24.
//

import SwiftUI
import Firebase

class UserViewModel: ObservableObject {
    
    @Published var user: User?
    @Published var driving = false
    @Published var showMissingUserError = false
    
    init() {
        fetchUserDetails()
    }
    
    func fetchUserDetails() {
        let db = Firestore.firestore()
        let ref = db.collection("User").document("\(Auth.auth().currentUser!.uid)")
        ref.getDocument { (document, error) in
            if let document = document, document.exists {
                if let data = document.data(){
                    self.user = User(data: data)
                    print(self.user!)
                    if self.user == nil {self.showMissingUserError = true}
                }
            } else {
                self.showMissingUserError = true
            }
        }
    }
}

