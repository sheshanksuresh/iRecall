//
//  ContentView.swift
//  iRecall
//
//  Created by Sheshank Suresh on 2023-10-14.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingLogin: Bool = false
    @State private var isShowingRegistration: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image("irecall_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Button(action: {
                    isShowingLogin = true
                }) {
                    Text("Login")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                NavigationLink(destination: LoginView(), isActive: $isShowingLogin) {
                    EmptyView()
                }
                .hidden()
                
                Button(action: {
                    isShowingRegistration = true
                }) {
                    Text("Register")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                NavigationLink(destination: RegistrationView(), isActive: $isShowingRegistration) {
                    EmptyView()
                }
                .hidden()
            }
            .padding()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


#Preview {
    ContentView()
}
