//
//  profile_view.swift
//  ChatAPP
//
//  Created by matus cuninka on 10/11/2023.
//
/*
import Foundation
import SwiftUI
import FirebaseDatabaseInternal
import FirebaseAuth


func updateName(username: String){
    let userUID = Auth.auth().currentUser?.uid
    let ref = Database.database(url: "https://chatappswiftui-eaa55-default-rtdb.europe-west1.firebasedatabase.app").reference()
    ref.child("users").child(userUID!).setValue(["username": username])
    print(ref)

}

class UserInformationHandling: ObservableObject {
    //@Published var username: String?=""
    /*
    func getUserName() async -> String {
        
        let ref = Database.database(url: "https://chatappswiftui-eaa55-default-rtdb.europe-west1.firebasedatabase.app").reference() // access to real time database and fix region error
        let userUID = Auth.auth().currentUser?.uid // get current userUID
        print(userUID as String? as Any)
        
        do {
            //let snapshot = try await ref.child("users/\(String(describing: userUID))/username").getData() // get username from real time database
            let snapshot = try await ref.child("users/3x5HjFLRhpRtwG5keP93nat0Rax2/username").getData() // get username from real time database
            print(snapshot)
            
            guard let retrievedUsername = snapshot.value as? String else {
                return "unknown"
            }
            print("retrievedUsername")
            return retrievedUsername
        } catch let error {
            print(error.localizedDescription)
            return "Unknown"
        }
    }
     */
    func getUserNameAsync() async -> String {
        var get_username: String = "unknown"
        let ref = Database.database(url: "https://chatapp-d30de-default-rtdb.europe-west1.firebasedatabase.app/").reference()
        let snapshot = try? await ref.child("users/3x5HjFLRhpRtwG5keP93nat0Rax2/username").getData()
        if let snapshot = snapshot {
            let userName = snapshot.value as? String ?? "Unknown"
            get_username = userName
            print(userName)
        } else {
            print("Error retrieving username")
        }
        return get_username
    }
}
struct ProfileView: View {
    
    @State private var change_password: String = "";
    @State private var change_password1: String = "";
    @State private var username: String = ""
    @ObservedObject var info_handling = UserInformationHandling()
    @State private var get_username: String = ""
    
    var body: some View {
        
        ZStack{
            Color(red: 0.16, green: 0.13, blue: 0.22)
                .ignoresSafeArea()
            
            
            
            NavigationStack{
                List {
                    
                    Section(header: Text("enter username (your username is: \(get_username)").task {
                        get_username = await info_handling.getUserNameAsync() // get username
                    }){
                        TextField(
                            "",
                            text: $username, prompt:Text("enter username").foregroundStyle(.white) // to change prompt color
                        ) // username
                        //.focused($focusField, equals: .password)
                        .submitLabel(.done)
                    }// Section
                    .listRowBackground(Color(red: 0.29, green: 0.23, blue: 0.44)) // backgroung color of section
                    .foregroundColor(.white) // name of section color
                    .submitLabel(.search)
                    
                    
                    
                    
                    
                    Section(header: Text("change password")){
                        
                        SecureField(
                            "",
                            text: $change_password, prompt:Text("enter password").foregroundStyle(.white) // to change prompt color
                        ) // password
                        //.focused($focusField, equals: .password)
                        .submitLabel(.done)
                    }//Section
                    .listRowBackground(Color(red: 0.29, green: 0.23, blue: 0.44)) // backgroung color of section
                    .foregroundColor(.white) // name of section color
                    .submitLabel(.done)
                    
                    Section(header: Text("re-type new password")){
                        
                        SecureField(
                            "",
                            text: $change_password1, prompt:Text("re-type new password").foregroundStyle(.white) // to change prompt color
                        ) // re-type password
                        //.focused($focusField, equals: .password)
                        .submitLabel(.done)
                    }//Section
                    .listRowBackground(Color(red: 0.29, green: 0.23, blue: 0.44)) // backgroung color of section
                    .foregroundColor(.white) // name of section color
                    .submitLabel(.done)
                    HStack {
                        Spacer()
                        
                        Section {
                            
                            //Submit button
                            Button("Submit", action: {
                                if(username.isEmpty){
                                    print("username it is not set")
                                } else {
                                    updateName(username: username)
                                    print("changing username")
                                }
                                /*Task {
                                    await info_handling.getUserNameAsync()
                                }*/
                                
                                
                            }) // button
                            
                        } //Section
                        .buttonStyle(PressEffectButtonStyle())
                        
                        Spacer()
                    } // HStack
                    .listRowBackground(Color(red: 0.16, green: 0.13, blue: 0.22)) // backgroung color of section
                } // List
                .background(Color(red: 0.16, green: 0.13, blue: 0.22))

                .scrollContentBackground(.hidden)
                
                .navigationTitle("Chat App") // name
                .toolbarColorScheme(.dark, for: .navigationBar) // change color of navigation title to white
                .navigationBarTitleDisplayMode(.inline) // move ChatAPP to the mid
                .toolbarBackground(
                    Color(red: 0.25, green: 0.19, blue: 0.39),
                    for: .navigationBar) //background color of the title
                .toolbarBackground(.visible, for: .navigationBar) // visible
            } // Navigation Stack
                
        }
        
        
        /*
        TabView {
                    RegisterView()
                        .tabItem {
                            Label("Menu", systemImage: "list.dash")
                        }

                    LoginView()
                        .tabItem {
                            Label("Order", systemImage: "person")
                        }
                }*/
    }
}

#Preview {
    ProfileView()
}
*/



//
//  profile_view.swift
//  ChatAPP
//
//  Created by matus cuninka on 18/11/2023.
//


import Foundation
import SwiftUI
import FirebaseDatabaseInternal
import FirebaseAuth
import Combine

func updateName(username: String){
    let userUID = Auth.auth().currentUser?.uid
    let ref = Database.database(url: "https://chatappswiftui-eaa55-default-rtdb.europe-west1.firebasedatabase.app").reference()
    ref.child("users").child(userUID!).setValue(["username": username])
    print(ref)

}


class UserInformationHandling: ObservableObject{
    
    
    
    @State private var ref = Database.database(url: "https://chatappswiftui-eaa55-default-rtdb.europe-west1.firebasedatabase.app/").reference() // access to real time database and fix region error
    

    @Published var value: String? = nil
    func getUserName(){
        
        ref.child("users/3x5HjFLRhpRtwG5keP93nat0Rax2/username").observeSingleEvent(of: .value) { snapshot in
            self.value = snapshot.value as? String ?? "load failed"
        }
        
    }
    
    
}


struct ProfileView: View {
    
    @State private var change_password: String = "";
    @State private var change_password1: String = "";
    @State private var username: String = ""
    //@StateObject private var info_handling = UserInformationHandling()
        
    
    var body: some View {
        
        ZStack{
            Color(red: 0.16, green: 0.13, blue: 0.22)
                .ignoresSafeArea()
            
            
            
            NavigationStack {
                List {
                    
                    Section(header: Text("enter username (your username is: \("Unknown")")){
                        TextField(
                            "",
                            text: $username, prompt:Text("enter username").foregroundStyle(.white) // to change prompt color
                        ) // username
                        //.focused($focusField, equals: .password)
                        .submitLabel(.done)
                    }// Section
                    .listRowBackground(Color(red: 0.29, green: 0.23, blue: 0.44)) // backgroung color of section
                    .foregroundColor(.white) // name of section color
                    .submitLabel(.search)
                    
                    
                    
                    
                    
                    Section(header: Text("change password")){
                        
                        SecureField(
                            "",
                            text: $change_password, prompt:Text("enter password").foregroundStyle(.white) // to change prompt color
                        ) // password
                        //.focused($focusField, equals: .password)
                        .submitLabel(.done)
                    }//Section
                    .listRowBackground(Color(red: 0.29, green: 0.23, blue: 0.44)) // backgroung color of section
                    .foregroundColor(.white) // name of section color
                    .submitLabel(.done)
                    
                    Section(header: Text("re-type new password")){
                        
                        SecureField(
                            "",
                            text: $change_password1, prompt:Text("re-type new password").foregroundStyle(.white) // to change prompt color
                        ) // re-type password
                        //.focused($focusField, equals: .password)
                        .submitLabel(.done)
                    }//Section
                    .listRowBackground(Color(red: 0.29, green: 0.23, blue: 0.44)) // backgroung color of section
                    .foregroundColor(.white) // name of section color
                    .submitLabel(.done)
                    HStack {
                        Spacer()
                        
                        Section {
                            
                            //Submit button
                            Button("Submit", action: {
                                if(username.isEmpty){
                                    print("username it is not set")
                                } else {
                                    updateName(username: username)
                                    print("changing username")
                                }
                                /*Task {
                                    await info_handling.getUserNameAsync()
                                }*/
                                
                                
                            }) // button
                            
                        } //Section
                        .buttonStyle(PressEffectButtonStyle())
                        
                        Spacer()
                    } // HStack
                    .listRowBackground(Color(red: 0.16, green: 0.13, blue: 0.22)) // backgroung color of section
                } // List
                .background(Color(red: 0.16, green: 0.13, blue: 0.22))

                .scrollContentBackground(.hidden)
                
                .navigationTitle("Chat App") // name
                .toolbarColorScheme(.dark, for: .navigationBar) // change color of navigation title to white
                .navigationBarTitleDisplayMode(.inline) // move ChatAPP to the mid
                .toolbarBackground(
                    Color(red: 0.25, green: 0.19, blue: 0.39),
                    for: .navigationBar) //background color of the title
                .toolbarBackground(.visible, for: .navigationBar) // visible
            } // Navigation Stack
                
        } //ZStack
        
       
        
        
        /*
        TabView {
                    RegisterView()
                        .tabItem {
                            Label("Menu", systemImage: "list.dash")
                        }

                    LoginView()
                        .tabItem {
                            Label("Order", systemImage: "person")
                        }
                }*/
    }
}

#Preview {
    ProfileView()
}

