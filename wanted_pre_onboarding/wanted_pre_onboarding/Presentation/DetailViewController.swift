//
//  DetailViewController.swift
//  wanted_pre_onboarding
//
//  Created by rae on 2022/06/13.
//

import UIKit

class DetailViewController: UIViewController {
    
    var weatherResponse: WeatherResponse? {
        didSet {
            self.configureWeatherResponse()
        }
    }
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let currentTempLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let feelsLikeTempLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let minTempLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let maxTempLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let pressureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let weatherDescLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var firstStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.cityNameLabel, self.currentTempLabel, self.feelsLikeTempLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var secondStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.humidityLabel, self.minTempLabel, self.maxTempLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var thirdStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.pressureLabel, self.windSpeedLabel, self.weatherDescLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
    }

}

private extension DetailViewController {
    func configure() {
        self.addSubViews()
        self.makeConstraints()
    }
    
    func addSubViews() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(iconImageView)
        self.view.addSubview(firstStackView)
        self.view.addSubview(secondStackView)
        self.view.addSubview(thirdStackView)
    }
    
    func makeConstraints() {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.firstStackView.translatesAutoresizingMaskIntoConstraints = false
        self.secondStackView.translatesAutoresizingMaskIntoConstraints = false
        self.thirdStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.iconImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            self.iconImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            self.firstStackView.topAnchor.constraint(equalTo: self.iconImageView.bottomAnchor, constant: 16.0),
            self.firstStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.firstStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            self.secondStackView.topAnchor.constraint(equalTo: self.firstStackView.bottomAnchor, constant: 16.0),
            self.secondStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.secondStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            
            self.thirdStackView.topAnchor.constraint(equalTo: self.secondStackView.bottomAnchor, constant: 16.0),
            self.thirdStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.thirdStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func configureWeatherResponse() {
        guard let weatherResponse = self.weatherResponse else { return }
        self.navigationItem.title = weatherResponse.name
        self.iconImageView.setImageUrl(iconString: weatherResponse.weather.first?.icon ?? "")
        
        self.cityNameLabel.attributedTitle(firstPart: "도시이름", secondPart: weatherResponse.name)
        self.currentTempLabel.attributedTitle(firstPart: "현재기온", secondPart: "\(weatherResponse.main.temp.convertToCelsiusString())º")
        self.feelsLikeTempLabel.attributedTitle(firstPart: "체감기온", secondPart: "\(weatherResponse.main.feelsLike.convertToCelsiusString())º")
        
        self.humidityLabel.attributedTitle(firstPart: "현재습도", secondPart: "\(weatherResponse.main.humidity)%")
        self.minTempLabel.attributedTitle(firstPart: "최저기온", secondPart: "\(weatherResponse.main.tempMin.convertToCelsiusString())º")
        self.maxTempLabel.attributedTitle(firstPart: "최고기온", secondPart: "\(weatherResponse.main.tempMax.convertToCelsiusString())º")
        
        self.pressureLabel.attributedTitle(firstPart: "기압", secondPart: "\(weatherResponse.main.pressure)hPa")
        self.windSpeedLabel.attributedTitle(firstPart: "풍속", secondPart: "\(weatherResponse.wind.speed)m/s")
        self.weatherDescLabel.attributedTitle(firstPart: "날씨설명", secondPart: weatherResponse.weather.first?.description ?? "")
    }
}
