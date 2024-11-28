//
//  HomeView.swift
//  Weather-take-home
//
//  Created by Fredy on 11/22/24.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @State private var isSearchActive = false
    @State private var selectedCity: String? = nil
    @State private var searchText = ""
    
    var body: some View {
            ZStack {
                // Weather card.
                ZStack {
                    VStack {
                        if let weather = viewModel.savedWeather {
        
                            WeatherHomeRow(weather: weather, viewModel: viewModel)
                        }
                    }
                    // "No City Selected" message.
                    if viewModel.savedWeather == nil {
                        VStack {
                            Spacer()
                            Text("No City Selected")
                                .foregroundColor(.primary)
                                .padding(.bottom, 8)
                                .font(.system(size: 30, weight: .semibold))
                            Text("Please Search For A City")
                                .foregroundColor(.primary)
                                .font(.system(size: 15, weight: .semibold))
                            Spacer()
                        }
                    }
                }
                //Search card.
                ZStack {
                    VStack {
                        TextField("Search Location", text: $searchText)
                            .padding()
                            .frame(height: 46)
                            .background(
                                Color.gray.opacity(0.1)
                                    .cornerRadius(16)
                            )
                            .overlay(
                                HStack {
                                    Spacer()
                                    Image(systemName: "magnifyingglass")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 10)
                                }
                            )
                            .onChange(of: searchText) {
                                Task{
                                    await viewModel.fetchWeather(for: searchText, tempUnit: .celsius)
                                }
                            }
                        
                        Spacer()
                        
                        // Search result.
                        if !searchText.isEmpty {
                            ZStack(alignment: .top) {
                                Color(UIColor.systemBackground)
                                            .edgesIgnoringSafeArea(.all) 
                                LazyVGrid(columns: [GridItem(.flexible())]){
                                    ForEach(viewModel.weatherSuggestion, id: \.self) { suggestion in
                                        WeatherResultRow(
                                            resultWeather: suggestion,
                                            temperatureFormatter: viewModel.formatTemperature
                                        )
                                        .onTapGesture {
                                            selectedCity = suggestion.name
                                            searchText = ""
                                            viewModel.saveWeatherToUserDefaults(suggestion.name, tempUnit: .celsius)
                                            viewModel.savedWeather = suggestion
                                        }
                                    }
                                    .listStyle(.plain)
                                }
                                Spacer()
                            }
                        }
                    }
                   
                }
                .onAppear {
                    // Fetch the last saved city's weather.
                    viewModel.loadWeatherFromUserDefaults(tempUnit: .celsius)
                }
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 16)
    }
    
    private func fetchWeather(for city: String) {
        Task{
            await viewModel.fetchWeather(for: city, tempUnit: .celsius)
        }
    }
}
