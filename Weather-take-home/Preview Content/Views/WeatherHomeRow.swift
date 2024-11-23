//
//  WeatherRow.swift
//  Weather-take-home
//
//  Created by Fredy on 11/22/24.
//

import SwiftUI

struct WeatherHomeRow: View {
    let weather: Weather
    var body: some View {
        VStack(spacing: 16) {
            
            // Weather icon.
            AsyncImage(url: URL(string: "https://openweathermap.org/img/w/\(weather.weather.first?.icon ?? "").png")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 123, height: 123) 
            } placeholder: {
                ProgressView()
            }
            
            // City name.
            HStack(spacing: 4) {
                Text(weather.name)
                    .font(.system(size: 30, weight: .semibold))
                Image(systemName: "location.fill")
                    .font(.system(size: 25))
            }.padding(.horizontal)
            
            // Temperature.
            HStack(alignment: .top, spacing: 0) {
                
                Text(formatTemperature(weather.main.temp))
                    .font(.system(size: 70, weight: .semibold))
                    .foregroundColor(.primary)
                Text("°")
                    .font(.system(size: 30, weight: .light))
                    .foregroundColor(.primary)
                
            }
            
            // Weather details section.
            HStack(spacing: 40) {
                VStack(spacing: 8) {
                    Text("Humidity")
                        .font(.system(size: 12, weight: .medium))
                    Text("\(weather.main.humidity, specifier: "%.0f")%")
                        .font(.system(size: 15, weight: .medium))
                    
                }
                VStack(spacing: 8) {
                    Text("UV")
                        .font(.system(size: 12, weight: .medium))
                    Text("4")
                        .font(.system(size: 15, weight: .medium))
                    
                }
                VStack(spacing: 8) {
                    Text("Feels Like")
                        .font(.system(size: 12, weight: .medium))
                    Text("\(formatTemperature(weather.main.feels_like))°")
                        .font(.system(size: 15, weight: .medium))
                }
            }
            .frame(height: 75)
            .padding(.horizontal, 44)
            .foregroundColor(.gray)
            .background(
                Color.gray.opacity(0.1)
                    .cornerRadius(16)
            )
        }
        .padding()
        .padding(.top, 88)
        .frame(maxWidth: .infinity)
        Spacer()
    }
    
    private func formatTemperature(_ temp: Double) -> String {
        let fahrenheitTemp = (temp * 9 / 5) + 32
        return String(format: "%.0f", fahrenheitTemp)
        
    }
}
