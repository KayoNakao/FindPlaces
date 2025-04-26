//
//  Places.swift
//  FindPlaces
//
//  Created by Kayo on 2025-04-25.
//

import Foundation

struct Places: Decodable {
    let places: [PlaceDetail]
}

struct PlaceDetail: Decodable {
    
    let id: String
    let displayName: DisplayName
    let formattedAddress: String
    let rating: Double?
    let photos: [Photo]?
}

struct DisplayName: Decodable {
    let text: String
}

struct Photo: Decodable {
    let name: String
}

struct PhotoMedia: Decodable {
    let name: String
    let photoUri: String
}
