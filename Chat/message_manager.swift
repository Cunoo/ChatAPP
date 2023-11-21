//
//  message_manager.swift
//  Chat
//
//  Created by matus on 19/11/2023.
//



import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI
import FirebaseAuth
import FirebaseDatabase
struct Message: Identifiable, Codable {
    var id: String
    var text: String
    var received: Bool
    var timestamp: Date
    var username:String
    var userUID: String
}




class MessagesManager: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published private(set) var lastMessageId: String = ""
    @Published private var get_username = UserInformationHandling()
    @Published private var value: String? = nil
    var ref = Database.database(url:"https://chatappswiftui-eaa55-default-rtdb.europe-west1.firebasedatabase.app/").reference() // acces to database
    var userUID = Auth.auth().currentUser?.uid // get current UID
    //get user uid
    @Published var tester: String? = nil
    
    
    func getUserIDFunc() -> String{
        //let userID = Auth.auth().currentUser?.uid
        let error = "Uid has been not found"
        if(userUID != nil){
            return userUID!
        } else{
            return error
        }
        
    }
    
    func getUsername()  -> String {
        var userName_1: String = ""
        ref.child("users/\(userUID!)/username").getData(completion:  { error, snapshot in
          guard error == nil else {
            print(error!.localizedDescription)
            return;
          }
            return userName_1 = snapshot?.value as? String ?? "Unknown";
            
        });
        //return userName_1
        //return tester!
        return userName_1
        
    }
    // Create an instance of our Firestore database
    let db = Firestore.firestore()
    
    // On initialize get messages
    init() {
        
        getMessages()
    }

    // Read message from Firestore in real-time with the addSnapShotListener
    func getMessages() {
        db.collection("messages").addSnapshotListener { querySnapshot, error in
            
            // if documents doesnt exit quit document
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \(String(describing: error))")
                return
            }
            
            // Mapping through the documents
            self.messages = documents.compactMap { document -> Message? in
                do {
                    // Converting each document into the Message model
                    // Note that data(as:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
                    return try document.data(as: Message.self)
                } catch {
                    // If we run into an error, print the error in the console
                    print("Error decoding document into Message: \(error)")

                    // Return nil if we run into an error - but the compactMap will not include it in the final array
                    return nil
                }
            }
            
            // Sorting the messages by sent date
            self.messages.sort { $0.timestamp < $1.timestamp }
            
            // Getting the ID of the last message so we automatically scroll to it in ContentView
            if let id = self.messages.last?.id {
                self.lastMessageId = id
            }
        }
    }
    // Add a message in Firestore
    func sendMessage(text: String) {
        
        do {
            // Create a new Message instance, with a unique ID, the text we passed, a received value set to false (since the user will always be the sender), and a timestamp
            let newMessage = Message(id: "\(UUID())", text: text, received: false, timestamp: Date(), username: getUsername(), userUID:getUserIDFunc())
            
            // Create a new document in Firestore with the newMessage variable above, and use setData(from:) to convert the Message into Firestore data
            // Note that setData(from:) is a function available only in FirebaseFirestoreSwift package - remember to import it at the top
            try db.collection("messages").document().setData(from: newMessage)
            
        } catch {
            // If we run into an error, print the error in the console
            print("Error adding message to Firestore: \(error)")
        }
    }
}
