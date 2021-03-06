//
//  DetailViewController.swift
//  wanted_pre_onboarding
//
//  Created by rae on 2022/06/13.
//

import UIKit

class DetailViewController: UIViewController {
    
    var weatherModel: WeatherModel? {
        didSet {
            self.configureWeatherModel()
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
    
    func configureWeatherModel() {
        guard let weatherModel = self.weatherModel else { return }
        self.navigationItem.title = weatherModel.koreanName
        self.iconImageView.setImageUrl(iconString: weatherModel.icon)
        
        self.cityNameLabel.attributedTitle(firstPart: "????????????", secondPart: weatherModel.koreanName)
        self.currentTempLabel.attributedTitle(firstPart: "????????????", secondPart: "\(weatherModel.temperature)??")
        self.feelsLikeTempLabel.attributedTitle(firstPart: "????????????", secondPart: "\(weatherModel.feelsLikeTemperature)??")
        
        self.humidityLabel.attributedTitle(firstPart: "????????????", secondPart: "\(weatherModel.humidity)%")
        self.minTempLabel.attributedTitle(firstPart: "????????????", secondPart: "\(weatherModel.minTemperature)??")
        self.maxTempLabel.attributedTitle(firstPart: "????????????", secondPart: "\(weatherModel.maxTemperature)??")
        
        self.pressureLabel.attributedTitle(firstPart: "??????", secondPart: "\(weatherModel.pressure)hPa")
        self.windSpeedLabel.attributedTitle(firstPart: "??????", secondPart: "\(weatherModel.windSpeed)m/s")
        self.weatherDescLabel.attributedTitle(firstPart: "????????????", secondPart: weatherModel.description)
    }
}
