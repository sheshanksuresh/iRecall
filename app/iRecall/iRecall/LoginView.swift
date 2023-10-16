//
//  LoginView.swift
//  iRecall
//
//  Created by Sheshank Personal on 2023-10-15.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Username", text: $username)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            Button(action: {
                loginUser()
            }) {
                Text("Login")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            })
        }
        .padding()
    }
    
    func loginUser() {
        guard let url = URL(string: "http://127.0.0.1:8000/users/login/") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let params = "username=\(username)&password=\(password)"
        request.httpBody = params.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                self.alertTitle = "Error"
                self.alertMessage = "Login failed. \(error.localizedDescription)"
                self.showingAlert = true
            }
            
            if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                       let dictionary = jsonObject as? [String: String],
                       let token = dictionary["token"] {
                        print(token) // TODO: Save as keychain for security, keeping to debug for now
                    }
                    self.alertTitle = "Success"
                    self.alertMessage = "Logged in successfully!"
                    self.showingAlert = true
                } else {
                    self.alertTitle = "Registration Failed"
                    self.alertMessage = "An error occured. Please try again."
                    self.showingAlert = true
                }
            }
        }.resume()
    }
}


#Preview {
    LoginView()
}
