//
//  HomeViewModel.swift
//  wanted_pre_onboarding
//
//  Created by rae on 2022/06/10.
//

import Foundation

class HomeViewModel {
    private(set) var weatherModels: Observable<[WeatherModel]>
    
    private let cityNames = ["Gongju", "Gwangju", "Gumi", "Gunsan", "Daegu", "Daejeon", "Mokpo", "Busan", "Seosan", "Seoul", "Sokcho", "Suwon", "Suncheon", "Ulsan", "Iksan", "Jeonju", "Jeju", "Cheonan", "Cheongju-si", "Chuncheon"]
    private let networkService: NetworkService
    
    init() {
        self.weatherModels = Observable([])
        self.networkService = NetworkService()
    }
    
    func fetch() {
        cityNames.forEach { cityName in
            let request = GeoRequest(cityName: cityName)
            self.networkService.request(request) { (result: Result<[GeoDTO], NetworkError>) in
                switch result {
                case .success(let geoDTOs):
                    guard let geoDTO = geoDTOs.first else { return }

                    let weatherRequest = WeatherRequest(lat: geoDTO.lat, lon: geoDTO.lon)
                    self.networkService.request(weatherRequest) { (result: Result<WeatherDTO, NetworkError>) in
                        switch result {
                        case .success(let weatherDTO):

                            let weatherModel = WeatherModel(koreanName: geoDTO.localNames.ko, weatherDTO: weatherDTO)
                            self.weatherModels.value.append(weatherModel)
                            self.weatherModels.value.sort {$0.koreanName < $1.koreanName}

                        case .failure(let error):
                            print("weatherError: \(error)")
                        }
                    }

                case .failure(let error):
                    print("geoError: \(error)")
                }
            }
        }
    }
}
