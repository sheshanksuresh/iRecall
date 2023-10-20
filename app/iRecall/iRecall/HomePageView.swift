//
//  HomePageView.swift
//  iRecall
//
//  Created by Sheshank Personal on 2023-10-15.
//

import Foundation
import SwiftUI

struct HomePageView: View {
    var body: some View {
        VStack {
            // Menu
            BannerView()
            
            // Calendar and Topics
            VStack {
                Text ("Calendar Placeholder")
                Divider()
                Text ("Today's Topics Placeholder")
            }
        }
    }
}

struct BannerView: View {
    var body: some View {
        HStack {
            Button(action: {
                // TODO: Implement logic to show menu
            }) {
                Image(systemName: "list.bullet")
            }
            Spacer()
            Text("User's Name") // TODO: Implement logic to replace this with logged in user's first name
            Image(systemName: "person.circle") // TODO: Implement logic to replace this with logged in user's profile picture
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
    }
}

#Preview {
    HomePageView()
}
