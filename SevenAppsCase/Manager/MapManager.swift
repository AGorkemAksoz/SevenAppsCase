//
//  MapManager.swift
//  SevenAppsCase
//
//  Created by Gorkem on 30.01.2025.
//

import MapKit


final class MapManager {
    static func generateMapAnnotationForUserLocation(for user: User) -> MKPointAnnotation? {
        guard let coordinate = generateCoordinate(for: user) else { return nil}
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = user.name
        return annotation
    }
    
    static func generateRegionForUserLocation(for user: User) -> MKCoordinateRegion? {
        guard let coordinate = generateCoordinate(for: user) else { return nil}
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        return region
    }
    
    private static func generateCoordinate(for user: User) -> CLLocationCoordinate2D? {
        guard let lat = Double(user.address.geo.lat), let lng = Double(user.address.geo.lng) else { return nil }
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        return coordinate
    }
}
