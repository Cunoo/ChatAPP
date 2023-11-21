//
//  TestView.swift
//  Chat
//
//  Created by matus on 19/11/2023.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        TabView {
            RegisterView()
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }

            LoginView()
                .tabItem {
                    Label("Order", systemImage: "person")
                }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
