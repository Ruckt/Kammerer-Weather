//
//  Kammerer_WeatherTests.swift
//  Kammerer WeatherTests
//
//  Created by Lichtenstein, Edan on 4/12/24.
//

import XCTest
@testable import Kammerer_Weather

final class Kammerer_WeatherTests: XCTestCase {

    let service = OpenWeatherServiceMock()
    
    // This test is primarily that the OpenWeatherResponse model has not been changed.
    func testGetCityWeather() async {

        let response = await service.getCityWeather(name: "Philadelphia", "PA", "US", true, apiKey: "1234")

        guard case let .success(weatherData) = response.result
        else {
            XCTFail()
            return
        }

        let details = weatherData.weather[0]
        let mainDescription = details.main
        let description = details.description
        let iconId = details.icon
        let temp = weatherData.main.temp
        let feelsLike = weatherData.main.feelsLike
        
        XCTAssert(mainDescription == "Clouds")
        XCTAssert(description == "broken clouds")
        XCTAssert(iconId == "04n")
        XCTAssert(temp == 287.95)
        XCTAssert(feelsLike == 286.74)
    }

}
