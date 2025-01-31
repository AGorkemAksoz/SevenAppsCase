//
//  UserDetailViewController.swift
//  SevenAppsCase
//
//  Created by Gorkem on 30.01.2025.
//

import MapKit
import UIKit

enum UserDetailSection: Int, CaseIterable {
    case personalInfo
    case address
    case workInfo
    case location // Added location section

    var title: String {
        switch self {
        case .personalInfo: return "Personal Info"
        case .address: return "Address"
        case .workInfo: return "Work Info"
        case .location: return "Location"
        }
    }
}

protocol UserDetailViewControllerInterface: AnyObject {
    func configureVC()
    func setupTableView()
}

// MARK: - User Detail ViewController
final class UserDetailViewController: UIViewController {
    private let viewModel: UserDetailViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UserDetailTableViewCell.self, forCellReuseIdentifier: UserDetailTableViewCell.identifier)
        return tableView
    }()
    
    init(user: User) {
        self.viewModel = UserDetailViewModel(user: user)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        setupTableView()
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
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension UserDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return UserDetailSection.allCases.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = UserDetailSection(rawValue: section) else { return nil } // Handle potential invalid raw values
        return section.title
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Still one row per section
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailTableViewCell.identifier, for: indexPath) as? UserDetailTableViewCell else {
            return UITableViewCell()
        }

        guard let section = UserDetailSection(rawValue: indexPath.section) else { return cell } // Guard against invalid section indices

        switch section {
        case .personalInfo:
            cell.configure(title: section.title, // Use enum for title
                         detail: "Name: \(viewModel.user.name)\nEmail: \(viewModel.user.email)\nPhone: \(viewModel.user.phone)\nWebsite: \(viewModel.user.website)")
        case .address:
            cell.configure(title: section.title, // Use enum for title
                         detail: "Street: \(viewModel.user.address.street)\nCity: \(viewModel.user.address.city)\nZipcode: \(viewModel.user.address.zipcode)")
        case .workInfo:
            cell.configure(title: section.title, // Use enum for title
                         detail: "Company: \(viewModel.user.company.name)\nCatchphrase: \(viewModel.user.company.catchPhrase)\nBusiness: \(viewModel.user.company.bs)")
        case .location:
            let annotation = MapManager.generateMapAnnotationForUserLocation(for: viewModel.user)
            let region = MapManager.generateRegionForUserLocation(for: viewModel.user)
            cell.configureWithMap(annotation: annotation, region: region)
        }

        return cell
    }
}
