//
//  Weather_take_homeApp.swift
//  Weather-take-home
//
//  Created by Fredy on 11/22/24.
//

import SwiftUI

@main
struct Weather_take_homeApp: App {
    @StateObject private var viewModel = WeatherViewModel()
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: viewModel)
        }
    }
}
