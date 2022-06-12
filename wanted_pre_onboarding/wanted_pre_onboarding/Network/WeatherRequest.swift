//
//  WeatherRequest.swift
//  wanted_pre_onboarding
//
//  Created by rae on 2022/06/10.
//

import Foundation

struct WeatherRequest: DataRequestable {
    private let apiKey = "5e5e6f8aeb40866917475875d86b54d6"
    private var cityName: String
    
    init(cityName: String) {
        self.cityName = cityName
    }
    
    var url: String {
        let baseURL: String = "http://api.openweathermap.org/data/2.5/weather"
        return baseURL
    }
    
    var queryItems: [String : String] {
        ["q": cityName, "appid": self.apiKey]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> WeatherResponse {
        let decoder = JSONDecoder()
        let response = try decoder.decode(WeatherResponse.self, from: data)
        return response
    }
}
