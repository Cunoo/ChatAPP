//
//  ContentView.swift
//  ChatAPP
//
//  Created by matus cuninka on 18/11/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

//buttons style
struct PressEffectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(Color(red: 0.29, green: 0.23, blue: 0.44))
            .padding(.horizontal, 8)
            .frame(width: 125,height: 44)
            .foregroundColor(.white)
            .background(Color(red: 0.29, green: 0.23, blue: 0.44))
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

struct LoginView: View {
    enum Field {
        case email,password
    }
    
    @State private var email: String = "";
    @State private var password: String = "";
    @FocusState private var focusField : Field?;
    @State private var buttonsDisabled = true;
    @State private var showingAlert = false // pop up error window
    @State private var signUpButtonPressed: Bool = false // disable alert when sign up
    
    
    
    
    
    var body: some View {
        
        ZStack{
            
            Color(red: 0.16, green: 0.13, blue: 0.22)
                .ignoresSafeArea()
            
            
            NavigationStack {
                List{
                    HStack {
                        Spacer()
                        Section{
                            
                            Image(systemName: "text.bubble") // image
                                .resizable() // allow resize image
                            
                                .padding()
                                .background(Color(red: 0.16, green: 0.13, blue: 0.22)) // background color of the image
                            
                            //.aspectRatio(contentMode: .fill)
                                .frame(width:250,height: 250)
                            
                        }//Section
                        Spacer()
                    }//HStack
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0)) // delete white lines around the image
                    .listRowBackground(Color(red: 0.16, green: 0.13, blue: 0.22))
                    
                    
                    Section(header: Text("email")){
                        TextField(
                            "",
                            text: $email, prompt:Text("enter email").foregroundColor(.white) // to change prompt color
                        )
                        .focused($focusField, equals: .email)
                        .disableAutocorrection(true)
                        
                    }//Section
                    .listRowBackground(Color(red: 0.29, green: 0.23, blue: 0.44)) // backgroung color of section
                    .foregroundColor(.white) // name & input of section color
                    .submitLabel(.next)
                    .onSubmit {
                        focusField = .password;
                    }
                    //.onChange(of: email){ _ in
                    //    enableButtons()
                    //}
                    
                    //password
                    Section(header: Text("password")){
                        
                        SecureField(
                            "",
                            text: $password, prompt:Text("enter password").foregroundColor(.white) // to change prompt color
                        ) // password
                        .focused($focusField, equals: .password)
                        .submitLabel(.done)
                    }//Section
                    .listRowBackground(Color(red: 0.29, green: 0.23, blue: 0.44)) // backgroung color of section
                    .foregroundColor(.white) // name of section color
                    .onSubmit {
                        focusField = nil; // will dismiss the keyboard
                    }
                    //.onChange(of: password){ _ in
                    //    enableButtons()
                    // }
                    
                    
                    //HStack{
                        Section {
                            Button(action: {
                                Task {
                                    do {
                                        try await Auth.auth().signIn(withEmail: email, password: password) // log in
                                        print("success")
                                        // Handle successful login, e.g., navigate to the next screen
                                        let window = UIApplication // set another view as root
                                            .shared
                                            .connectedScenes
                                            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                                            .first { $0.isKeyWindow }
                                        window?.rootViewController = UIHostingController(rootView: TabbingView()) // set HomeView as root
                                        window?.makeKeyAndVisible()
                                    } catch {
                                        print(error.localizedDescription)
                                        showingAlert = true // login error
                                        
                                    }
                                }
                            }
                            ) {
                                Text("Log In")
                                    .background(Color(red: 0.29, green: 0.23, blue: 0.44))
                                    .padding(.horizontal, 8)
                                    .frame(width: 125,height: 44)
                                    .foregroundColor(.white)
                                    .background(Color(red: 0.29, green: 0.23, blue: 0.44))
                                    .cornerRadius(8)
                                    
                                    .buttonStyle(.borderless)
                                
                                
                            }
                            .listRowBackground(Color(red: 0.16, green: 0.13, blue: 0.22))
                            //.buttonStyle(PressEffectButtonStyle())
                            .alert("Your email or password is wrong!", isPresented: $showingAlert) {
                                Button("OK", role: .cancel) { }
                            } // check correct email or passwords
                            
//                            ForEach((1...8), id: \.self){_ in
//                                Spacer() // spacing between buttons
//                            }
                            
                            
                        } //Section
                        Section {
                            NavigationLink(destination: RegisterView()) {
                                Text("Sign Up")
                                .background(Color(red: 0.29, green: 0.23, blue: 0.44))
                                .padding(.horizontal, 8)
                                .frame(width: 120,height: 40)
                                .foregroundColor(.white)
                                .background(Color(red: 0.29, green: 0.23, blue: 0.44))
                                .cornerRadius(8)
                            } // NavigatonLink
                        }
                        //.disabled(buttonsDisabled) // allow buttons when both field are filled
                        
                    //}// HStack
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
                //.scrollDisabled(true) //disable scrolling
                //.ignoresSafeArea(.keyboard, edges: .bottom) //<- here
                
                
                
                
            } // navigation stack
            
            
            
        } // ZStack
    } // body
    
    //validation function
    func enableButtons(){
        let emailValidation = email.count > 6 && email.contains("@")
        let passwordValidation = email.count > 6
        buttonsDisabled = !(emailValidation && passwordValidation)
    }
    
    //login function
    //    static func login(email: String, password: String){
    //        Task {
    //            do {
    //                try await Auth.auth().signIn(withEmail: email, password: password)
    //                print("success")
    //                // Handle successful login, e.g., navigate to the next screen
    //            } catch {
    //                print(error.localizedDescription)
    //
    //                // Handle login error, e.g., show an error message to the user
    //            }
    //        }
    //    }
    
} // LoginView



struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
