//
//  HomeViewModel.swift
//  FindPlaces
//
//  Created by Kayo on 2025-04-25.
//

import Foundation
import CoreLocation

class HomeViewModel: NSObject {
    
    private let apiClient = APIClient()
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    var currentKeyword: Keyword = .cafe
    var places: [PlaceDetail] = []
    var photoMedias: [String: PhotoMedia] = [:]
    var onPlacesUpdate: (() -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getPlaces(for keyword: Keyword) async throws {
        guard let location = currentLocation else { return }
        do {
            let result = try await apiClient.getPlaces(forKeyword: keyword.apiName, location: location)
            self.places = result.places
            photoMedias = try await getPhotos()
        } catch {
            self.places = []
            print(#function, error.localizedDescription)
            throw error
        }
    }
    
    func getPhotos() async throws -> [String: PhotoMedia] {
        
        let photoMedias = try await withThrowingTaskGroup(of: [String: PhotoMedia].self) { group in
            for place in places {
                group.addTask {
                    do {
                        let photoMedia = try await self.apiClient.getPhoto(forPlace: place)
                        return [place.id: photoMedia]
                    } catch {
                        print(#function, error.localizedDescription)
                        throw error
                    }
                }
            }
            var output: [String: PhotoMedia] = [:]
            for try await dic in group {
                for (key, value) in dic {
                    output[key] = value
                }
            }
            return output
        }
        return photoMedias
    }
}

extension HomeViewModel: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location has been approved")
            locationManager.requestLocation()
        case .denied, .restricted:
            print(LocationError.noLocationAccess.title)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            print(LocationError.noLocationAccess.title)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        currentLocation = location
        Task {
            try? await getPlaces(for: currentKeyword)
            onPlacesUpdate?()
        }
    }
    
}
