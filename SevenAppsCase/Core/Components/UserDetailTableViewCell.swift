//
//  UserDetailTableViewCell.swift
//  SevenAppsCase
//
//  Created by Gorkem on 30.01.2025.
//

import MapKit
import UIKit

// MARK: - User Detail TableViewCell
final class UserDetailTableViewCell: UITableViewCell {
    static let identifier = "UserDetailTableViewCell"
    
    private let titleLabel = UILabel()
    private let detailLabel = UILabel()
    private let mapView = MKMapView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.numberOfLines = 0
        detailLabel.numberOfLines = 0
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, detailLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(title: String, detail: String) {
        titleLabel.text = title
        detailLabel.text = detail
    }
    
    func configureWithMap(annotation: MKPointAnnotation?, region: MKCoordinateRegion?) {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mapView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        if let annotation = annotation {
            mapView.addAnnotation(annotation)
        }
        if let region = region {
            mapView.setRegion(region, animated: true)
        }
    }
}
