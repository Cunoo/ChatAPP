
//
//  profile_view.swift
//  ChatAPP
//
//  Created by matus cuninka on 18/11/2023.
//


import Foundation
import SwiftUI

var USERNAME: String = ""


struct ProfileView: View {
    
    @State private var change_password: String = "";
    @State private var change_password1: String = "";
    @State private var username: String = ""
    @StateObject private var info_handling = UserInformationHandling()
    @State private var tmp_username: String = ""
    
    
    @State private var change_password_invalid:Bool = false
    @State private var change_password_valid: Bool = false
    @State private var change_username:Bool = false
    @State private var all_at_once:Bool = false
    func getName() -> Text {
        if info_handling.value != nil {
            
            return Text("enter username (your username is: \(info_handling.value!)")
            
        }
        else {
            return Text("Username is not set")
        }
    }
    
    var body: some View {
        
        ZStack{
            Color(red: 0.16, green: 0.13, blue: 0.22)
                .ignoresSafeArea()
            
            
            NavigationStack {
                List {
                    
                    Section(header: getName().onAppear{ info_handling.observerDataChange() // always appear username if is set
                        
                    }) {
                        TextField(
                            "",
                            text: $username, prompt:Text("enter username")
                                .foregroundColor(.white)// to change prompt color
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
                            text: $change_password, prompt:Text("enter password")
                                .foregroundColor(.white)// to change prompt color
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
                            text: $change_password1, prompt:Text("re-type new password")
                                .foregroundColor(.white)// to change prompt color
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
                                    info_handling.observerDataChange()
                                } else {
                                    info_handling.updateName(username: username)
                                    print("changing username")
                                    change_username = true
                                    
                                }
                                if(!change_password.isEmpty && (change_password1 == change_password)){
                                    info_handling.changePassword(password: change_password)
                                    change_password_valid = true
                                    
                                    
                                }
                                if(change_password.isEmpty && (change_password1 != change_password)) {
                                }
                                
                                if( change_username == true && change_password_valid == true) {
                                    all_at_once = true
                                    //change_username = false
                                    //change_password_valid = false
                                }
                                
                            }) // button
                            
                            // alerts for actions
                            .alert("Information has been changed succesfully!", isPresented: $all_at_once) {
                                Button("OK", role: .cancel) { }
                            }
                            .alert("Passwords doesn't match!", isPresented: $change_password_invalid) {
                                Button("OK", role: .cancel) { }
                            }
                            .alert("Password has been changed succesfully!", isPresented: $change_password_valid) {
                                Button("OK", role: .cancel) { }
                            }
                            .alert("Username has been changed succesfully!", isPresented: $change_username) {
                                Button("OK", role: .cancel) { }
                            }
                            
                            
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
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}



