//
//  Weather.swift
//  Weather-take-home
//
//  Created by Fredy on 11/22/24.
//


import Foundation

struct Weather: Codable, Hashable {
    let main: Main
    let weather: [WeatherCondition]
    let name: String
    
    struct Main: Codable, Hashable{
        let temp: Double
        let humidity: Double
        let feels_like: Double
        let uvi: Int? // Only available in subscription plans.
    }

    struct WeatherCondition: Codable, Hashable {
        let description: String
        let icon: String
    }
}
