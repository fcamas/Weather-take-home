import Testing
import Foundation
@testable import Weather_take_home

struct WeatherServiceTests {
  
    struct Mocks {
        let mockURLProtocol: MockURLProtocol
    }

    private func makeSut() -> (WeatherService, Mocks) {
        let mockURLProtocol = MockURLProtocol()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        return (
            WeatherService(session: session),
            .init(mockURLProtocol: mockURLProtocol)
        )
    }

  
    @Test("Fetch Weather with Mock Data")
    func testFetchWeatherWithMockData() async throws {
        // Mock Weather JSON Response
        let mockWeatherData = """
        {
            "main": {
                "temp": 22.0,
                "humidity": 60,
                "feels_like": 21.0,
                "uvi": 3
            },
            "weather": [{
                "description": "clear sky",
                "icon": "01d"
            }],
            "name": "Paris"
        }
        """.data(using: .utf8)!

        // Set up the system under test (SUT)
        let (sut, _) = makeSut()

        // Configure MockURLProtocol with the mock data
        MockURLProtocol.mockData = mockWeatherData
        MockURLProtocol.mockResponse = HTTPURLResponse(
            url: URL(string: "https://mockurl.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )
        MockURLProtocol.mockError = nil

        // Fetch Weather
        let weather = try #require(await sut.fetchWeather(for: "Paris"))

        // Validate fetched weather data
        #expect(weather.main.temp == 22.0, "Expected temp to be 22.0")
        #expect(weather.main.humidity == 60.0, "Expected humidity to be 60.0")
        #expect(weather.main.feels_like == 21.0, "Expected feels_like to be 21.0")
        #expect(weather.weather.first?.description == "clear sky", "Expected description to be 'clear sky'")
        #expect(weather.name == "Paris", "Expected city name to be 'Paris'")
    }
}
