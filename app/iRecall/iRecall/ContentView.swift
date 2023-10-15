//
//  ContentView.swift
//  iRecall
//
//  Created by Sheshank Suresh on 2023-10-14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("irecall_logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Button(action: {
                // TODO: Login action logic
            }) {
                Text("Login")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Button(action: {
                // TODO: Register action logic
            }) {
                Text("Register")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }.padding()
    }
}

#Preview {
    ContentView()
}
