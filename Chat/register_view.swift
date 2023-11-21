//
//  register_view.swift
//  ChatAPP
//
//  Created by matus cuninka on 18/11/2023.
//


import SwiftUI
import FirebaseCore
import FirebaseAuth

struct userInformation {
    var email: String
    var password: String
    var password_validation: String
}


//func signUpUser(email: String, password: String) -> any View {
//
//    // Attempt to create a new user with the given email and password
//    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//        // This completion block will be executed once the user creation operation is completed
//
//        if let error = error {
//            // If there is an error during the user creation process, handle the error
//            print("Error creating user: \(error.localizedDescription)")
//        } else if let authResult = authResult {
//            // If the user creation is successful, you can access the user information in authResult
//
//            print("User created successfully. User ID: \(authResult.user.uid)")
//        }
//    } as! (any View)
//}

struct RegisterView: View {
    @State private var email: String = "";
    @State private var password: String = "";
    @State private var password_check: String = "";
    @State private var emailValid = false; // if email is valid
    @State private var passwordValid = false; // if password is valid
    @State private var userCreated = false; // pop up window for creating user
    
    var body: some View {
        
        ZStack{
            
            Color(red: 0.16, green: 0.13, blue: 0.22)
            .ignoresSafeArea()

            
            NavigationStack {
                
                
                List{
                    Spacer().listRowBackground(Color(red: 0.16, green: 0.13, blue: 0.22))
                    Spacer().listRowBackground(Color(red: 0.16, green: 0.13, blue: 0.22))
                    Spacer().listRowBackground(Color(red: 0.16, green: 0.13, blue: 0.22))
                    Section(header: Text("email")){
                        
                        TextField(
                            "",
                            text: $email, prompt:Text("Enter email").foregroundColor(.white) // to change prompt color
                        )
                        .disableAutocorrection(true)
                       
                        
                    }//Section
                    .listRowBackground(Color(red: 0.29, green: 0.23, blue: 0.44)) // backgroung color of section
                    .foregroundColor(.white) // name of section color
                    .submitLabel(.next)
                    
                    Section(header: Text("password")){
                        TextField(
                            "",
                            text: $password, prompt:Text("Enter password").foregroundColor(.white) // to change prompt color
                        )
                        
                        
                       
                        
                    }//Section
                    .listRowBackground(Color(red: 0.29, green: 0.23, blue: 0.44)) // backgroung color of section
                    .foregroundColor(.white) // name of section color
                    .submitLabel(.next)
                    
                    Section(header: Text("Retype password")){
                        TextField(
                            "",
                            text: $password_check, prompt:Text("Enter password").foregroundColor(.white) // to change prompt color
                        )
                        
                       
                        
                    }//Section
                    .listRowBackground(Color(red: 0.29, green: 0.23, blue: 0.44)) // backgroung color of section
                    .foregroundColor(.white) // name of section color
                    .submitLabel(.done)
                    
                    
                    
                    //.onChange(of: email){ _ in
                    //    enableButtons()
                    //}
                    
                    //password
                 
                    //.onChange(of: password){ _ in
                    //    enableButtons()
                   // }
                    
                    HStack{
                            Spacer() // move button to mid
                            Button(action: {
                                if(password == password_check){
                                    print("your password is valid")
                                    // Attempt to create a new user with the given email and password
                                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                                        
                                        if let error = error {
                                            // If there is an error during the user creation process, handle the error
                                            print("Error creating user: \(error.localizedDescription)")
                                            emailValid = true
                                        } else if let authResult = authResult {
                                            // If the user creation is successful, you can access the user information in authResult
                                            
                                            print("User created successfully. User ID: \(authResult.user.uid)")
                                            userCreated = true // pop up aler for user created
                                        }
                                    }
                                } else {
                                    print("password is invalid")
                                    passwordValid = true // pop up alert if password are not the same
                                }
                            }) {
                                Text("Sign Up")
                            }
                            .alert("Email is already in use!", isPresented: $emailValid) {
                                Button("OK", role: .cancel) { }
                            }
                            .alert("Passwords are not the same!", isPresented: $passwordValid) {
                                Button("OK", role: .cancel) { }
                            }
                            .alert("User created!", isPresented: $userCreated) {
                                Button("OK", role: .cancel) { }
                            }
                            
                            .alert("User created!", isPresented: $userCreated) {
                                        Button("OK", role: .cancel) {
                                            let window = UIApplication
                                                .shared
                                                .connectedScenes
                                                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                                                            .first { $0.isKeyWindow }
                                            window?.rootViewController = UIHostingController(rootView: LoginView()) // set LoginView as root
                                                    window?.makeKeyAndVisible()
                                        }
                                    } // if passwords are the same
                            .buttonStyle(PressEffectButtonStyle())
                            .padding(20)
                            Spacer() // move button to mid
                        //.disabled(buttonsDisabled) // allow buttons when both field are filled

                            
                    }// HStack
                    .listRowBackground(Color(red: 0.16, green: 0.13, blue: 0.22))

                } // list
                
                .background(Color(red: 0.16, green: 0.13, blue: 0.22))

                .scrollContentBackground(.hidden)
                
                .navigationTitle("Chat App") // name
                .toolbarColorScheme(.dark, for: .navigationBar) // change color of navigation title to white
                .navigationBarTitleDisplayMode(.inline) // move ChatAPP to the mid
                .toolbarBackground(
                    Color(red: 0.25, green: 0.19, blue: 0.39),
                    for: .navigationBar) //background color of the title
                .toolbarBackground(.visible, for: .navigationBar) // visible
                //.scrollDisabled(true) //disable scrolling
                //.ignoresSafeArea(.keyboard, edges: .bottom) //<- here

                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink("", destination: LoginView())
                    }
                }
            } // navigation stack
            
                        
            
        } // ZStack
        
    }
}




struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
