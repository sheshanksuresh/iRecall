//
//  HomeView.swift
//  iRecall
//
//  Created by Sheshank Personal on 2023-10-15.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State private var isMenuOpen: Bool = false
    
    var body: some View {
        ZStack {
            HomePageView()
            
            if isMenuOpen {
                SideMenuView()
                    .transition(.move(edge: .leading))
            }
        }
        .navigationBarItems(leading: Button(action: {
            withAnimation {
                isMenuOpen.toggle()
            }
        }) {
            Image(systemName: "list.dash")
        })
    }
}
