//
//  WeatherModel.swift
//  wanted_pre_onboarding
//
//  Created by rae on 2022/06/13.
//

import Foundation

struct WeatherModel: Hashable {
    let uuid = UUID()
    let koreanName: String
    let weatherDTO: WeatherDTO
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    static func == (lhs: WeatherModel, rhs: WeatherModel) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    var temperature: String {
        return weatherDTO.main.temp.convertToCelsiusString()
    }
    
    var feelsLikeTemperature: String {
        return weatherDTO.main.feelsLike.convertToCelsiusString()
    }
    
    var minTemperature: String {
        return weatherDTO.main.tempMax.convertToCelsiusString()
    }
    
    var maxTemperature: String {
        return weatherDTO.main.tempMax.convertToCelsiusString()
    }
    
    var humidity: Int {
        return weatherDTO.main.humidity
    }
    
    var icon: String {
        return weatherDTO.weather.first?.icon ?? ""
    }
    
    var pressure: Int {
        return weatherDTO.main.pressure
    }
    
    var windSpeed: Double {
        return weatherDTO.wind.speed
    }
    
    var description: String {
        return weatherDTO.weather.first?.description ?? ""
    }
}
