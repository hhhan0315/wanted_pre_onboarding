//
//  WeatherResponse.swift
//  wanted_pre_onboarding
//
//  Created by rae on 2022/06/10.
//

import Foundation

struct WeatherResponse: Codable, Hashable, Equatable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let name: String
    let id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: WeatherResponse, rhs: WeatherResponse) -> Bool {
        return lhs.id == rhs.id
    }
}

struct Coord: Codable {
    let lon: Double?
    let lat: Double?
}

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double?
    let tempMin: Double?
    let tempMax: Double?
    let pressure: Int?
    let humidity: Int?
    let seaLevel: Int?
    let grndLevel: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
    }
}

struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}
