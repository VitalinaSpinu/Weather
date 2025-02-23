//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Vitalina Spinu on 10.02.2025.
//

import XCTest
import Combine
@testable import Weather

class WeatherViewModelTests: XCTestCase {
    var viewModel: WeatherViewModel!
    var mockService: MockWeatherService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockService = MockWeatherService()
        viewModel = WeatherViewModel(weatherService: mockService)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testLoadWeather_Success() {
        
        let mockWeatherData = WeatherModel(
            main: MainWeather(temp: 25, temp_min: 20, temp_max: 30),
            weather: [WeatherDescription(description: "Sunny")]
        )
        mockService.mockWeatherData = mockWeatherData
        
        let expectation = XCTestExpectation(description: "Weather data loaded")
        
        viewModel.$description
            .dropFirst()
            .sink { description in
                XCTAssertEqual(self.viewModel.temp, "25", "The temperature should be 25°C.")
                XCTAssertEqual(description, "Sunny", "The description should be 'Sunny'")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadWeather(lat: "40.7128", lon: "-74.0060")
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testLoadWeather_Failure() {
        
        mockService.shouldReturnError = true

        let expectation = XCTestExpectation(description: "Weather fetch failed")
        
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                XCTAssertNotNil(errorMessage, "There should be an error message")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.loadWeather(lat: "40.7128", lon: "-74.0060")
        
        wait(for: [expectation], timeout: 1.0)
    }
}
