//
//  ContentView.swift
//  iRecall
//
//  Created by Sheshank Suresh on 2023-10-14.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoginView: Bool = true
    
    var body: some View {
        NavigationView{
            VStack {
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(.secondarySystemFill))
                    .cornerRadius(8)
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemFill))
                    .cornerRadius(8)
                
                if isLoginView {
                    Button("Login"){
                        // TODO: Login Logic
                    }.padding()
                    
                    Button("Switch to Register") {
                        isLoginView.toggle()
                    }.padding()
                } else {
                    Button("Register") {
                        isLoginView.toggle()
                    }.padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
