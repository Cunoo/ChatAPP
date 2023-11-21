//
//  TabView.swift
//  Chat
//
//  Created by matus on 21/11/2023.
//

import SwiftUI

struct TabbingView: View {
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color(red: 0.25, green: 0.19, blue: 0.39)) // change TabView background color on initialization
        
    }
    var body: some View {
        TabView {
            Group {
                HomeView()
                    .tabItem {
                        Label("Chats", systemImage: "message.fill")
                        //.foregroundColor(.white)
                        
                    }
                
                
                
                
                
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                        //.foregroundColor(.white)
                        
                    }
            } // Group
        } //TabView
        .onAppear() {
            UITabBar.appearance().barTintColor = .white
        }
        .toolbarBackground(.red, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabbingView()
    }
}
