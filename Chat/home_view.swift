//
//  HomeView.swift
//  ChatAPP
//
//  Created by matus cuninka on 18/11/2023.
//



import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


struct HomeView: View {
    @StateObject var messagesManager = MessagesManager()
    @State private var addBorder: Bool = false
    @State private var message = ""
    @State private var message_sent:Bool = false
    @StateObject private var info_handling = UserInformationHandling()
    @State private var test:String? = ""
    //signout
    func signOut(){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            print("user logout")
            // Logout
            let window = UIApplication // set another view as root
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                            .first { $0.isKeyWindow }
            window?.rootViewController = UIHostingController(rootView: LoginView()) // set Login as root
                    window?.makeKeyAndVisible()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    var body: some View {
        ZStack {
            Color(red: 0.16, green: 0.13, blue: 0.22)
                .ignoresSafeArea()
                
            VStack (){
                HStack {
                    Rectangle()
                                    .frame(height: 0)
                                    .background(.ultraThinMaterial)
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .padding()
                        .foregroundColor(.white)
                    Text("ChatGroup").foregroundColor(.white)
                    
                        .frame(width: 100, height: 25)
                    
                        .foregroundColor(.white)
                    ForEach((1...8), id: \.self){_ in
                        Spacer() // spacing between items
                    }
                    Button {
                        print("logout")
                        signOut()
                    } label: {
                        Image(systemName: "arrow.down.message")
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                            .padding()
                            .foregroundColor(.white)
                    }
                    
                }//HStack TitleRow
                .frame(width: .infinity, alignment: .center)
                .background(Color(red: 0.25, green: 0.19, blue: 0.39))
                .navigationTitle(Text("Style"))
               
                
                
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(messagesManager.messages, id: \.id) { message in
                            
                            if(message.received == true) {
                                Text(message.username)
                                    .foregroundColor(.blue)
                                    .font(.system(size: 20))
                                    .frame(
                                        maxWidth: 325,
                                        maxHeight: 450,
                                        alignment: .trailing // move text to right
                                        
                                    )
                                
                                
                                Text(message.text).foregroundColor(.white)
                                //.font(.headline)
                                    .font(.system(size: 30))
                                    .frame(
                                        maxWidth: 325,
                                        maxHeight: 450,
                                        alignment: .trailing // move text to right
                                        
                                    )
                                //.border(Color.blue)
                                    .background(Color(red: 0.19, green: 0.16, blue: 0.25))
                                    .padding(.bottom)
                                    .cornerRadius(14)
                                
                                
                                
                            }
                            if(message.received == false) {
                                Text(message.text).foregroundColor(.white)
                                    .font(.system(size: 30))
                                    .frame(
                                        maxWidth: 325,
                                        maxHeight: 450,
                                        alignment: .leading // move text to left
                                        
                                    )
                                //.background(Color(red: 0.29, green: 0.23, blue: 0.44))
                                    .cornerRadius(14)
                                    .padding(.bottom)
                                    .background(
                                        LinearGradient(
                                            colors: [Color(red: 0.29, green: 0.23, blue: 0.44)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .multilineTextAlignment(.leading) // multiline to left
                                    .fixedSize(horizontal: false, vertical: true)
                                
                                
                                //.border(Color.orange)
                            }
                        }//ForEach
                    }//ScrollView
                    .onChange(of: messagesManager.lastMessageId) { id in
                        // When the lastMessageId changes, scroll to the bottom of the conversation
                        withAnimation {
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                    
                    
                }//ScrollViewReader
                
               
                Section{
                    HStack {
                        
                        TextField("", text: $message, prompt:Text("Enter your message").foregroundColor(.white),
                                  axis: .vertical
                        )//.textFieldStyle(.plain)
                            
                            //.frame(width: 250, height: 75)
                            //.background(Color(red: 0.29, green: 0.23, blue: 0.44))
                            .padding()
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(.white) // input color
                            
                            .multilineTextAlignment(.leading) // multiline to left
                            
                            .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color(red: 0.29, green: 0.23, blue: 0.44), style: StrokeStyle(lineWidth: 1.0))
                                
                                )
                            .padding()
                        
                        Button {
                            print("sending image..")
//                            if((messagesManager.getName() == "Username is not set") ) {
//                                message_sent = true
//                                message = ""
//                            } else {
                            messagesManager.sendMessage(text: message)
                            //}
                        } label: {
                            Image(systemName: "paperplane")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(.trailing)
                        }
//                        .alert("Your username is not set you cant send a message!", isPresented: $message_sent) {
//                            Button("OK", role: .cancel) { }
//                        }
                        .submitLabel(.done)
                        .controlSize(.large)
                        .onTapGesture {
                            message = ""
                        }
                        
                    }
                }
                //.frame(maxWidth: .infinity, maxHeight: .infinity)
                //.background(Color(red: 0.16, green: 0.13, blue: 0.22))
                
            } //VStack
            .background(Color(red: 0.16, green: 0.13, blue: 0.22))
            
        }
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}






