## Weather Tracker iOS Take-Home Test

## Table of Contents
1. Objective
2. Overview
3. Product Spec
4. UI Design
5. Local Storage
6. Networking
7. Setup Instructions

## Objective
The goal of this project is to build a weather app using Swift, SwiftUI, and clean architecture. The app should allow users to search for a city, display its weather on the home screen, and persist the selected city across launches. The app should integrate data from WeatherAPI.com to fetch real-time weather data, and follow Figma designs for the UI.

## Overview 
The Weather Tracker app allows users to search for a city, view detailed weather conditions (including temperature, humidity, UV index, and "feels like" temperature), and persist the selected city across launches. Users can query the weather for a specific city using the search bar, view the weather on the home screen, and tap search results to update the displayed city. The app utilizes WeatherAPI.com to fetch current weather data.

## App Evaluation
- Category: Weather
- Platform: iOS (built using Swift and SwiftUI)
- Story: The app allows users to quickly check the weather for their selected city and provides details on the current weather conditions.
- Market: Ideal for users who need quick weather updates and for those who travel frequently.
- Scope: Simple yet effective weather app that offers the essential weather details.

## Product Spec

## 1. User Stories (Required and Optional)

Required Must-have Stories
- [x] User can search for weather by city name.
- [x] The app displays weather data for the selected city, including:
  - Temperature
  - Weather condition (with corresponding icon)
  - Humidity (%)
  - UV index
  - Feels like temperature
- [x] The app persists the selected city using UserDefaults.
- [x] If no city is saved, the user is prompted to search for a city.
  
<!--  Optional Nice-to-have Stories -->
<!-- [ ] User can toggle between Fahrenheit and Celsius. -->
<!-- [ ] User can view an hourly forecast for the selected city. -->
<!-- [ ] User can view weather details for multiple cities. -->

## 2. Screen Archetypes
- [x] Home Screen
  - Displays weather information for the saved city (temperature, condition, humidity, etc.).
  - If no city is saved, prompts the user to search for a city.
  - Search bar to query new cities.
  
- [x] Search Results
  - Displays weather data for queried cities.
  - Tapping a search result updates the Home Screen with the city’s weather and persists the selection.

## 3. UI Design
- Home Screen:
  - Displays current weather for a saved city.
  - Shows a search bar at the top for city queries.
  - Displays weather details: temperature, weather condition with an icon, humidity, UV index, and feels like temperature.
  
- Search Results:
  - Displays a search result card for cities matching the query.
  - Tapping a result updates the Home Screen with the new city's weather and persists it.

## 4. Local Storage
- UserDefaults is used to persist the selected city between app launches.
- The app loads and displays weather for the saved city when the app is reopened.
- If no city is saved, the app will prompt the user to search for one.

## 5. Networking
- The app uses the WeatherAPI.com to fetch current weather data. Example API request for a city:

  GET /current.json?q={city_name}&key={API_KEY}

- The response will include:
  - Temperature
  - Weather condition (with an icon URL)
  - Humidity (%)
  - UV index
  - Feels like temperature

- Error Handling: The app should handle potential errors gracefully, including invalid city names, network issues, and API rate limits.

## 6. Setup Instructions
## 1. Clone the repository:
   - Run the following command to clone the project:
     ```
     git clone https://github.com/your-repo/Weather-take-home.git
     ```

## 2. Open the project in Xcode:
   - Open WeatherTracker.xcodeproj in Xcode.

## 3. Install Dependencies (if applicable):
   - If using any dependencies like CocoaPods or Swift Package Manager, run the necessary commands to install them.

## 4. Run the app:
   - Build and run the app on an iOS simulator or device.

## Schema

Models
Weather Model  
| Property      | Type     | Description                               |
|---------------|----------|-------------------------------------------|
| cityName      | String   | Name of the city for which weather is fetched |
| temperature   | Double   | Current temperature                       |
| condition     | String   | Weather description (e.g., "Sunny")       |
| humidity      | Int      | Current humidity level                   |
| uvIndex       | Float    | UV index value                           |
| feelsLike     | Float    | Feels like temperature                   |
| iconURL       | String   | URL of the weather icon                  |
