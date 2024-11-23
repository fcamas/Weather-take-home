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

    private var weatherService: WeatherServiceProtocol
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }

    func fetchWeather(for city: String) async {
        do {
            let weather = try await weatherService.fetchWeather(for: city)
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

    func saveWeatherToUserDefaults(_ weather: Weather) {
        do {
            let data = try JSONEncoder().encode(weather)
            UserDefaults.standard.set(data, forKey: "mySavedWeatherData")
        } catch {
            print("Failed to save weather data: \(error.localizedDescription)")
        }
    }

    func loadWeatherFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "mySavedWeatherData") {
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    self.savedWeather = weather
                }
            } catch {
                print("Failed to load weather data: \(error.localizedDescription)")
            }
        }
    }

    func formatTemperature(_ temp: Double) -> String {
        let fahrenheitTemp = (temp * 9 / 5) + 32
        return String(format: "%.0f°", fahrenheitTemp)
    }
}
