//
//  SwiftUIVPNApp.swift
//  SwiftUIVPN
//
//  Created by Angelos Staboulis on 19/5/25.
//

import SwiftUI

@main
struct SwiftUIVPNApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(choice: false, ipAddress: "",viewModel: .init(),model:.init(city: "", country: "", org: "", loc: ""),lat:0,lon:0)
        }
    }
}
