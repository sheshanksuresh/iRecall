//
//  MainView.swift
//  iRecall
//
//  Created by Sheshank Personal on 2023-10-15.
//

import Foundation
import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            HomeView()
                .navigationBarTitle("Memory Retention App", displayMode: .inline)
        }
    }
}
