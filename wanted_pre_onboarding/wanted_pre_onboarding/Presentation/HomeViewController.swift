//
//  HomeViewController.swift
//  wanted_pre_onboarding
//
//  Created by rae on 2022/06/09.
//

import UIKit

class HomeViewController: UIViewController {
    
    enum Section {
        case city
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, WeatherResponse>
    
    private var dataSource: DataSource?
    
    private let viewModel: HomeViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 80
        return tableView
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configure()
        self.viewModel.fetch()
    }
}

private extension HomeViewController {
    func configure() {
        self.addSubViews()
        self.makeConstraints()
        self.configureNavigationItem()
        self.configureDataSource()
        self.bind(to: self.viewModel)
    }
    
    func addSubViews() {
        self.view.addSubview(self.tableView)
    }
    
    func makeConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func configureNavigationItem() {
        self.navigationItem.title = "날씨 정보"
    }
    
    func configureDataSource() {
        self.dataSource = DataSource(tableView: self.tableView, cellProvider: { tableView, indexPath, weatherResponse in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
                return HomeTableViewCell()
            }
            cell.weatherResponse = weatherResponse
            return cell
        })
    }
    
    func bind(to viewModel: HomeViewModel) {
        viewModel.weatherResponses.observe(on: self) { [weak self] weatherResponses in
            var snapShot = NSDiffableDataSourceSnapshot<Section, WeatherResponse>()
            snapShot.appendSections([Section.city])
            snapShot.appendItems(weatherResponses)
            self?.dataSource?.apply(snapShot, animatingDifferences: false)
        }
    }
}
