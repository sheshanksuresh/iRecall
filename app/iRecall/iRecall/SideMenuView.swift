//
//  SideMenuView.swift
//  iRecall
//
//  Created by Sheshank Personal on 2023-10-15.
//

import Foundation
import SwiftUI

struct SideMenuView: View {
    @Binding var isMenuOpen: Bool
    let bannerHeight: CGFloat = 50
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Button(action: {
                withAnimation {
                    isMenuOpen = false
                }
                // TODO: Transition to Home page
            }) {
                Text("Home Page")
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            }
            
            Button(action: {
                withAnimation {
                    isMenuOpen = false
                }
                // TODO: Transition to topics page
            }) {
                Text("Topics")
                    .padding()
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            }
            
            Button(action: {
                withAnimation {
                    isMenuOpen = false
                }
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
        .offset(y: bannerHeight)
    }
}

#Preview {
    SideMenuView(isMenuOpen: .constant(false))
}
