//
//  Constants.swift
//  FindPlaces
//
//  Created by Kayo on 2025-04-25.
//

import Foundation

enum Constants {
    
    static let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? "Fail"
    static let post = "POST"
    static let get = "GET"
    static let contentType = "application/json"
    static let contentTypeHeader = "Content-Type"
    static let apiKeyHeader = "X-Goog-Api-Key"
    static let fieldMaskHeader = "X-Goog-FieldMask"
    static let errorTitle = "Ooops!"
    static let errorMessage = "Sorry, something went wrong. Please try again later."
    
    enum URL {
        static let base = "https://places.googleapis.com/v1/"
        
        case placeNearby, photo(String)
        var endpoint: String {
            switch self {
                case .placeNearby:
                return Constants.URL.base + "places:searchNearby"
            case .photo(let id):
                return Constants.URL.base + id
            }
        }
        
        
    }
}
