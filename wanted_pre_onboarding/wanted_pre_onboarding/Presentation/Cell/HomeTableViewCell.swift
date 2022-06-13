//
//  HomeTableViewCell.swift
//  wanted_pre_onboarding
//
//  Created by rae on 2022/06/10.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    static let identifier = String(describing: HomeTableViewCell.self)
    
    var weatherResponse: WeatherDTO? {
        didSet {
            self.configureWeatherResponse()
        }
    }
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let cityNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let humidityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.cityNameLabel, self.temperatureLabel, self.humidityLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.iconImageView.image = nil
        self.cityNameLabel.text = nil
        self.temperatureLabel.text = nil
        self.humidityLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HomeTableViewCell {
    func configure() {
        self.addSubViews()
        self.makeConstraints()
    }
    
    func addSubViews() {
        self.contentView.addSubview(self.iconImageView)
        self.contentView.addSubview(self.labelStackView)
    }
    
    func makeConstraints() {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.labelStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.iconImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.iconImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.iconImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.iconImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 1/4),
            
            self.labelStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.labelStackView.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor),
            self.labelStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            self.labelStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
        ])
    }
    
    func configureWeatherResponse() {
        guard let weatherResponse = weatherResponse else { return }
        self.cityNameLabel.attributedTitle(firstPart: "도시이름", secondPart: weatherResponse.name)
        self.temperatureLabel.attributedTitle(firstPart: "현재기온", secondPart: "\(weatherResponse.main.temp.convertToCelsiusString())º")
        self.humidityLabel.attributedTitle(firstPart: "현재습도", secondPart: "\(weatherResponse.main.humidity)%")
        self.iconImageView.setImageUrl(iconString: weatherResponse.weather.first?.icon ?? "")
    }
}
