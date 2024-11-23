//
//  WeatherSuggestionRow.swift
//  Weather-take-home
//
//  Created by Fredy on 11/22/24.
//

import SwiftUI

struct WeatherResultRow: View {
    let resultWeather: Weather
    let temperatureFormatter: (Double) -> String
    
    var body: some View {
        VStack {
            HStack {
                //Weather Name And Temp Section
                VStack{
                    Text(resultWeather.name)
                        .foregroundColor(.primary)
                        .font(.system(size: 30, weight: .semibold))
                    HStack(alignment: .top, spacing: 0) {
                        Text(temperatureFormatter(resultWeather.main.temp))
                            .font(.system(size: 42, weight: .semibold))
                            .foregroundColor(.black)
                    }
                }
                Spacer()
                //Weather Image Section
                AsyncImage(url: URL(string: "https://openweathermap.org/img/w/\(resultWeather.weather.first?.icon ?? "").png")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 85, height: 85)
                } placeholder: {
                    ProgressView()
                }
            }.padding(.horizontal, 24)
       
        }
        .frame(height: 117)
        //.contentShape(Rectangle())
        .foregroundColor(.gray)
        .background(
            Color.gray.opacity(0.1)
                .cornerRadius(16)
        )
    }
}
