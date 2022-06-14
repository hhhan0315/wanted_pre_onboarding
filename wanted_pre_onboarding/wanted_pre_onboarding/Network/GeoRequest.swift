//
//  GeoRequest.swift
//  wanted_pre_onboarding
//
//  Created by rae on 2022/06/13.
//

import Foundation

struct GeoRequest: DataRequestable {
    private let apiKey = Bundle.main.weatherApiKey
    private var cityName: String
    
    init(cityName: String) {
        self.cityName = cityName
    }
    
    var url: String {
        let baseURL: String = "http://api.openweathermap.org/geo/1.0/direct"
        return baseURL
    }
    
    var queryItems: [String : String] {
        ["q": cityName, "appid": self.apiKey, "limit": "1"]
    }
    
    var method: HTTPMethod {
        .get
    }
    
    func decode(_ data: Data) throws -> [GeoDTO] {
        let decoder = JSONDecoder()
        let response = try decoder.decode([GeoDTO].self, from: data)
        return response
    }
}
