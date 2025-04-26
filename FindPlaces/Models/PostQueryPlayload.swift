//
//  PostQueryPlayload.swift
//  FindPlaces
//
//  Created by Kayo on 2025-04-25.
//

import Foundation

enum PlaceField: String, CaseIterable {
    case id = "places.id"
    case displayName = "places.displayName"
    case photos = "places.photos"
    case formattedAddress = "places.formattedAddress"
    case rating = "places.rating"
    
    static var defaultMask: String {
        Self.allCases.map(\.rawValue).joined(separator: ",")
    }
}

struct PostRequestPayload: Encodable {
    let includedTypes: [String]
    let maxResultCount: Int
    let locationRestriction: LocationRestriction
}

struct LocationRestriction: Encodable {
    let circle: Circle
}

struct Circle: Encodable {
    let center: Center
    let radius: Double
}

struct Center: Encodable {
    let latitude: Double
    let longitude: Double
}
