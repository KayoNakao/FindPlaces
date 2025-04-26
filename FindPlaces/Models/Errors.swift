//
//  Errors.swift
//  FindPlaces
//
//  Created by Kayo on 2025-04-25.
//

import Foundation

enum PlacesError: Error {
    case invalidUrl, invalidResponse, badRequestError, serverError
    
    var message: String {
        switch self {
        case .invalidUrl, .invalidResponse, .badRequestError, .serverError:
            return Constants.errorMessage
        }
    }
}

enum LocationError: Error {
    case noLocationAccess
    
    var title: String {
        switch self {
        case .noLocationAccess:
            return "No Location Access"
        }
    }
    
    var message: String {
        switch self {
        case .noLocationAccess:
            return "Please grant location access in settings to allow the app to find places around you."
        }
    }
    
}
