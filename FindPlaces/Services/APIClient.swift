//
//  APIClient.swift
//  FindPlaces
//
//  Created by Kayo on 2025-04-25.
//

import Foundation
import CoreLocation

class APIClient {
            
    func getPlaces(forKeyword keyword: String, location: CLLocation) async throws -> Places {
        guard let request = createPostRequest(location: location, keyword: keyword) else {
            throw PlacesError.invalidUrl
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { throw PlacesError.invalidResponse }
            let responseType = ResponseType.get(statusCode: response.statusCode)
            
            switch responseType {
            case .informational, .redirection, .serverError, .undefined:
                print("DEBUG: server error in request")
                throw PlacesError.serverError
            case .clientError:
                print("DEBUG: bad server request error")
                throw PlacesError.badRequestError
            case .success:
                print(String(data: data, encoding: .utf8) ?? "Invalid JSON")
                let decodedJson = try JSONDecoder().decode(Places.self, from: data)
                return decodedJson
            }
        } catch {
            print("DEBUG: \(error.localizedDescription)")
            throw PlacesError.badRequestError
        }
    }
    
    func getPhoto(forPlace place: PlaceDetail) async throws -> PhotoMedia {
        guard let request = createPhotosRequest(ForPlace: place) else {
            throw PlacesError.invalidUrl
        }
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { throw PlacesError.invalidResponse }
            let responseType = ResponseType.get(statusCode: response.statusCode)
            
            switch responseType {
            case .informational, .redirection, .serverError, .undefined:
                throw PlacesError.serverError
            case.clientError:
                throw PlacesError.badRequestError
            case .success:
                let decodedJson = try JSONDecoder().decode(PhotoMedia.self, from: data)
                return decodedJson
            }
            
        } catch {
            print(error.localizedDescription)
            throw PlacesError.badRequestError
        }
    }
    
    private func createPostRequest(location: CLLocation, keyword: String) -> URLRequest? {
        
        guard let url = URL(string: Constants.URL.placeNearby.endpoint) else {
            print("Invalid URL")
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = Constants.post
        
        request.addValue(Constants.contentType, forHTTPHeaderField: Constants.contentTypeHeader)
        request.addValue(Constants.apiKey, forHTTPHeaderField: Constants.apiKeyHeader)
        request.addValue(PlaceField.defaultMask, forHTTPHeaderField: Constants.fieldMaskHeader)
        
        let payload = PostRequestPayload(
            includedTypes: [keyword],
            maxResultCount: 3,
            locationRestriction: LocationRestriction(
                circle: Circle(
                    center: Center(
                        latitude: location.coordinate.latitude,
                        longitude: location.coordinate.longitude
                    ),
                    radius: 500)))

        do {
            let jsonData = try JSONEncoder().encode(payload)
            request.httpBody = jsonData
        } catch {
            print("Error serializing JSON: \(error)")
            return nil
        }
        return request
        
        
    }
    
    private func createPhotosRequest(ForPlace place: PlaceDetail) -> URLRequest? {
        guard let photoId = place.photos?.first?.name,
              let url = URL(string: "\(Constants.URL.photo(photoId).endpoint)/media?key=\(Constants.apiKey)&skipHttpRedirect=true&maxHeightPx=400&maxWidthPx=400") else {
            print("Invalid URL")
            return nil
        }
                
        var request = URLRequest(url: url)
        request.httpMethod = Constants.get
        return request
    }
    
}
