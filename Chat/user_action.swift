//
//  user_action.swift
//  ChatAPP
//
//  Created by matus cuninka on 12/11/2023.
//

import Foundation
import FirebaseDatabaseInternal
import FirebaseAuth
import Combine


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



class ObjectDemo: Encodable,Decodable {
    var id:String = ""
    var value:String = ""
}
extension Encodable {
    var toDictionary: [String:Any]? {
        
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
    }
}

// user info handling
class UserInformationHandling: ObservableObject{
    var ref = Database.database().reference() // acces to database
    var userUID = Auth.auth().currentUser?.uid
    @Published var value: String? = nil // get username from database
    //@Published var username: String? = ""
    
    
    func getUserName()  -> String {
        var get_username:String? = "Unknown"
        ref.child("users/\(userUID!)/username").getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return;
          }
            
            get_username = snapshot?.value as? String ?? "Unknown";
        });
        return get_username!
    }
    //get username REALTIME when is changed
    func observerDataChange(){
        ref.child("users/\(userUID!)/username").observe(.value) { snapshot in
            self.value = snapshot.value as? String ?? "Load Failed"
        }
    }
    //update name
    func updateName(username: String){
        let ref = Database.database().reference()
        ref.child("users").child(userUID!).setValue(["username": username])
        print(ref)

    }
    
    func changePassword(password: String){
        let user = Auth.auth().currentUser // get current user
        //var credential: AuthCredential

        // Prompt the user to re-provide their sign-in credentials

        if user != nil {
            Auth.auth().currentUser?.updatePassword(to: password) { error in
                print(error!)
            }
        } else {
          // No user is signed in.
          // ...
        }
    }
    
    
}
