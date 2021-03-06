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
    
    typealias DataSource = UITableViewDiffableDataSource<Section, WeatherModel>
    
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

// MARK: - Private Extension

private extension HomeViewController {
    func configure() {
        self.addSubViews()
        self.makeConstraints()
        self.configureNavigationItem()
        self.configureDelegate()
        self.configureDataSource()
        self.bind(to: self.viewModel)
    }
    
    func addSubViews() {
        self.view.backgroundColor = .white
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
        self.navigationItem.title = "?????? ??????"
    }
    
    func configureDelegate() {
        self.tableView.delegate = self
    }
    
    func configureDataSource() {
        self.dataSource = DataSource(tableView: self.tableView, cellProvider: { tableView, indexPath, weatherModel in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
                return HomeTableViewCell()
            }
            cell.weatherModel = weatherModel
            return cell
        })
    }
    
    func bind(to viewModel: HomeViewModel) {
        viewModel.weatherModels.observe(on: self) { [weak self] weatherModels in
            var snapShot = NSDiffableDataSourceSnapshot<Section, WeatherModel>()
            snapShot.appendSections([Section.city])
            snapShot.appendItems(weatherModels)
            self?.dataSource?.apply(snapShot, animatingDifferences: false)
        }
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        let weatherModel = self.dataSource?.itemIdentifier(for: indexPath)
        detailViewController.weatherModel = weatherModel
        self.navigationController?.pushViewController(detailViewController, animated: true)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }    
}
