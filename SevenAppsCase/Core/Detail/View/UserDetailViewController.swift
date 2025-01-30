//
//  UserDetailViewController.swift
//  SevenAppsCase
//
//  Created by Gorkem on 30.01.2025.
//

import MapKit
import UIKit

protocol UserDetailViewControllerInterface: AnyObject {
    func configureVC()
    func setupTableView()
    func setupMapView()
}

// MARK: - User Detail ViewController
final class UserDetailViewController: UIViewController {
    private let viewModel: UserDetailViewModel
    private let mapManager: MapManager = MapManager.instance
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let sections: [String] = ["Personal Info", "Address", "Work Info", "Location"]
    private let mapView = MKMapView()
    
    init(user: User) {
        self.viewModel = UserDetailViewModel(user: user)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    @objc private func openInMaps() {
        guard let mapItem = mapManager.generateMapItemForUserLocation(for: viewModel.user) else { return }
        mapItem.openInMaps(launchOptions: nil)
    }
}

extension UserDetailViewController: UserDetailViewControllerInterface {
    func configureVC() {
        view.backgroundColor = .systemMint
        title = viewModel.user.name
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.register(UserDetailTableViewCell.self, forCellReuseIdentifier: UserDetailTableViewCell.identifier)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupMapView() {
        guard let annotation = mapManager.generateMapAnnotationForUserLocation(for: viewModel.user) else { return }
        mapView.addAnnotation(annotation)
        guard let region = mapManager.generateRegionForUserLocation(for: viewModel.user) else { return }
        mapView.setRegion(region, animated: true)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openInMaps))
        mapView.addGestureRecognizer(tapGesture)
        mapView.isUserInteractionEnabled = true
    }
    
}

extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailTableViewCell.identifier, for: indexPath) as? UserDetailTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case 0:
            cell.configure(title: "Personal Info", detail: "Name: \(viewModel.user.name)\nEmail: \(viewModel.user.email)\nPhone: \(viewModel.user.phone)\nWebsite: \(viewModel.user.website)")
        case 1:
            cell.configure(title: "Address", detail: "Street: \(viewModel.user.address.street)\nCity: \(viewModel.user.address.city)\nZipcode: \(viewModel.user.address.zipcode)")
        case 2:
            cell.configure(title: "Work Info", detail: "Company: \(viewModel.user.company.name)\nCatchphrase: \(viewModel.user.company.catchPhrase)\nBusiness: \(viewModel.user.company.bs)")
        case 3:
            let annotation = mapManager.generateMapAnnotationForUserLocation(for: viewModel.user)
            let region = mapManager.generateRegionForUserLocation(for: viewModel.user)
            cell.configureWithMap(annotation: annotation, region: region)
        default:
            break
        }
        
        return cell
    }
}
