//
//  user_action.swift
//  ChatAPP
//
//  Created by matus cuninka on 12/11/2023.
//

import Foundation
import FirebaseAuth



//get user uid
func getUserID() {
    guard let userID = Auth.auth().currentUser?.uid else { return }
    print(userID)
}

//signout
func signOut(){
    let firebaseAuth = Auth.auth()
    do {
      try firebaseAuth.signOut()
        print("user logout")
        changeRootView()
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
}
