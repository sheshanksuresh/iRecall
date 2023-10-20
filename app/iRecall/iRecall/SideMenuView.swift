//
//  SideMenuView.swift
//  iRecall
//
//  Created by Sheshank Personal on 2023-10-15.
//

import Foundation
import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                // TODO: Transition to Home page
            }) {
                Text("Home Page")
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            }
            
            Button(action: {
                // TODO: Transition to topics page
            }) {
                Text("Topics")
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            }
            
            Button(action: {
                // TODO: Transition to forgetting curve page
            }) {
                Text("The Forgetting Curve")
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            }
            
            Spacer()
        }
        .frame(width: 250)
        .background(Color.gray.opacity(0.2))
    }
}

#Preview {
    SideMenuView()
}
