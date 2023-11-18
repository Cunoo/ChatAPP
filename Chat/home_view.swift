//
//  HomeView.swift
//  ChatAPP
//
//  Created by matus cuninka on 18/11/2023.
//



import SwiftUI
import FirebaseAuth



func changeRootView(){
    let window = UIApplication
        .shared
        .connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                    .first { $0.isKeyWindow }
    window?.rootViewController = UIHostingController(rootView: LoginView()) // set HomeView as root
            window?.makeKeyAndVisible()
}

struct HomeView: View {
    var body: some View {
        Text("hello")
        Button("logout", action: signOut)
        Button("id", action: {
            getUserID()
        })
        TabView {
                    HomeView()
                        .tabItem {
                            Label("Menu", systemImage: "list.dash")
                        }

//                    ProfileView()
//                        .tabItem {
//                            Label("Order", systemImage: "person")
//                        }
                }
    }
}

#Preview {
    HomeView()
}
