//
//  HomeViewModel.swift
//  wanted_pre_onboarding
//
//  Created by rae on 2022/06/10.
//

import Foundation

class HomeViewModel {
    private(set) var weatherResponses: Observable<[WeatherDTO]>
    private let cityNames = ["Gongju", "Gwangju", "Gumi", "Gunsan", "Daegu", "Daejeon", "Mokpo", "Busan", "Seosan", "Seoul", "Sokcho", "Suwon", "Suncheon", "Ulsan", "Iksan", "Jeonju", "Jeju", "Cheonan", "Cheongju-si", "Chuncheon"]
    private let networkService: NetworkService
    
    init() {
        self.weatherResponses = Observable([])
        self.networkService = NetworkService()
    }
    
    func fetch() {
        cityNames.forEach { cityName in
            let request = WeatherRequest(cityName: cityName)
            self.networkService.request(request) { (result: Result<WeatherDTO, NetworkError>) in
                switch result {
                case .success(let weatherResponse):
                    self.weatherResponses.value.append(weatherResponse)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
