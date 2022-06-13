//
//  WeatherRequest.swift
//  wanted_pre_onboarding
//
//  Created by rae on 2022/06/10.
//

import Foundation

struct WeatherRequest: DataRequestable {
    private let apiKey = Bundle.main.weatherApiKey
    private var cityName: String
    
    init(cityName: String) {
        self.cityName = cityName
    }
    
    var url: String {
        let baseURL: String = "http://api.openweathermap.org/data/2.5/weather"
        return baseURL
    }
    
    var queryItems: [String : String] {
        ["q": cityName, "appid": self.apiKey, "lang": "kr"]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> WeatherDTO {
        let decoder = JSONDecoder()
        let response = try decoder.decode(WeatherDTO.self, from: data)
        return response
    }
}
