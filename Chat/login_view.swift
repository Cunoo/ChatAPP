//
//  ContentView.swift
//  ChatAPP
//
//  Created by matus cuninka on 06/11/2023.
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
    
    
    
    
    
    
    var body: some View {
        
        ZStack{
            
            Color(red: 0.16, green: 0.13, blue: 0.22)
            .ignoresSafeArea()

            
            NavigationStack {
                
                
                List{
                    Section{
                        Image(systemName: "text.bubble") // image
                            .resizable() // allow resize image
                        
                        .padding()
                        .background(Color(red: 0.16, green: 0.13, blue: 0.22)) // background color of the image
                        
                        .aspectRatio(contentMode: .fill)
                        
                    }//Section
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0)) // delete white lines around the image
                    
                    Section(header: Text("email")){
                        TextField(
                            "",
                            text: $email, prompt:Text("enter email").foregroundStyle(.white) // to change prompt color
                        )
                        .focused($focusField, equals: .email)
                        
                    }//Section
                    .listRowBackground(Color(red: 0.29, green: 0.23, blue: 0.44)) // backgroung color of section
                    .foregroundColor(.white) // name of section color
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
                            text: $password, prompt:Text("enter password").foregroundStyle(.white) // to change prompt color
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
                    
                    
                    HStack{
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
                                        window?.rootViewController = UIHostingController(rootView: HomeView()) // set HomeView as root
                                                window?.makeKeyAndVisible()
                                    } catch {
                                        print(error.localizedDescription)
                                        showingAlert = true // login error
                                        
                                    }
                                }
                            }) {
                                Text("Log In")
                                
                            }
                            //.buttonStyle(PressEffectButtonStyle())
                            .alert("Your email or password is wrong!", isPresented: $showingAlert) {
                                        Button("OK", role: .cancel) { }
                                    } // check correct email or passwords
                            
                            ForEach((1...8), id: \.self){_ in
                                Spacer() // spacing between buttons
                            }
                                
                            NavigationLink(destination: RegisterView()) {
                                Button("Sign Up") {
                                }
                                .background(Color(red: 0.29, green: 0.23, blue: 0.44))
                                .padding(.horizontal, 8)
                                .frame(width: 125,height: 44)
                                .foregroundColor(.white)
                                .background(Color(red: 0.29, green: 0.23, blue: 0.44))
                                .cornerRadius(8)
                            } // NavigatonLink
                        
                            
                        } //Section
                        //.disabled(buttonsDisabled) // allow buttons when both field are filled
                        
                    }// HStack
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
    static func login(email: String, password: String){
        Task {
            do {
                try await Auth.auth().signIn(withEmail: email, password: password)
                print("success")
                // Handle successful login, e.g., navigate to the next screen
            } catch {
                print(error.localizedDescription)
                
                // Handle login error, e.g., show an error message to the user
            }
        }
    }

} // LoginView




#Preview {
    LoginView()
}

