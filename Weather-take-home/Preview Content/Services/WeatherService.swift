//
//  WeatherService.swift
//  Weather-take-home
//
//  Created by Fredy on 11/22/24.
//


import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(for city: String, tempUnit: TempUnit) async throws -> Weather
}

enum TempUnit: String {
    case celsius = "metric"
    case fahrenheit = "imperial"
}

struct WeatherAPI {
    static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    static let apiKey = "14111f719570723842194aefd9b5e41b"
}

class WeatherService: WeatherServiceProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchWeather(for city: String, tempUnit: TempUnit) async throws -> Weather {
        let urlString = "\(WeatherAPI.baseURL)?q=\(city)&appid=\(WeatherAPI.apiKey)&units=\(tempUnit.rawValue)"
        guard let url = URL(string: urlString) else {
            throw WeatherServiceError.invalidResponse
        }

        let (data, response) = try await session.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw WeatherServiceError.invalidData
        }

        do {
            return try JSONDecoder().decode(Weather.self, from: data)
        } catch {
            throw WeatherServiceError.decodingError
        }
    }
}

enum WeatherServiceError: Error {
    case invalidResponse
    case invalidData
    case networkError
    case decodingError
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return "Invalid response from the server."
        case .invalidData:
            return "The data received from the server is invalid."
        case .networkError:
            return "Network connection issue. Please check your internet."
        case .decodingError:
            return "Failed to decode the weather data."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}

