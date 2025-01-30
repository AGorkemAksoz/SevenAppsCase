//
//  MapManager.swift
//  SevenAppsCase
//
//  Created by Gorkem on 30.01.2025.
//

import MapKit


final class MapManager {
    static let instance = MapManager()
    private init() { }
    
    func generateMapAnnotationForUserLocation(for user: User) -> MKPointAnnotation? {
        guard let coordinate = generateCoordinate(for: user) else { return nil}
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = user.name
        return annotation
    }
    
    func generateRegionForUserLocation(for user: User) -> MKCoordinateRegion? {
        guard let coordinate = generateCoordinate(for: user) else { return nil}
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        return region
    }
    
    func generateMapItemForUserLocation(for user: User) -> MKMapItem? {
        guard let coordinate = generateCoordinate(for: user) else { return nil}
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = user.name
        return mapItem
    }
    
    private func generateCoordinate(for user: User) -> CLLocationCoordinate2D? {
        guard let lat = Double(user.address.geo.lat), let lng = Double(user.address.geo.lng) else { return nil }
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        return coordinate
    }
}
