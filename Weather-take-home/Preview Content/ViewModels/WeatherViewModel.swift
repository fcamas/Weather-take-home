//
//  WeatherViewModel.swift
//  Weather-take-home
//
//  Created by Fredy on 11/22/24.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var savedWeather: Weather?
    @Published var weatherSuggestion: [Weather] = []
    @Published var errorMessage: String?
    @Published var city: String?

    private var weatherService: WeatherServiceProtocol
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }

    func fetchWeather(for city: String, tempUnit: TempUnit) async {
        do {
            let weather = try await weatherService.fetchWeather(for: city, tempUnit: tempUnit)
            DispatchQueue.main.async {
                self.weatherSuggestion = [weather]
                self.errorMessage = nil  // Clear error message on success
  
            }
        } catch let error {
            DispatchQueue.main.async {
                
                self.errorMessage = error.localizedDescription
                self.weatherSuggestion = []
 
            }
        }
    }

    func saveWeatherToUserDefaults(_ city: String, tempUnit: TempUnit) {
            UserDefaults.standard.set(city, forKey: "mySavedWeatherData")
        DispatchQueue.main.async {
            self.city = city
            Task{
                await self.fetchWeather(for: city, tempUnit: tempUnit)
                self.savedWeather = self.weatherSuggestion.first
            }
        }
    }

    func loadWeatherFromUserDefaults(tempUnit: TempUnit) {
        if let city = UserDefaults.standard.string(forKey: "mySavedWeatherData") {
            DispatchQueue.main.async {
                self.city = city
                // Fetch the weather and update savedWeather only here
                Task {
                    await self.fetchWeather(for: city, tempUnit: tempUnit)
                    self.savedWeather = self.weatherSuggestion.first
                }
            }
        }
    }

    func formatTemperature(_ temp: Double) -> String {
        return String(format: "%.0f°", temp)
    }
}
