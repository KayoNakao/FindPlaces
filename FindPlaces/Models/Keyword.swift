//
//  Keyword.swift
//  FindPlaces
//
//  Created by Kayo on 2025-04-24.
//

import Foundation

enum Keyword : Int, CaseIterable, Codable {
    
    case cafe,
         gym,
         beauty_salon,
         food,
         burger,
         pizza,
         sushi,
         doctor,
         gas_station,
         florist,
         tourist_attraction,
         car_wash,
         supermarket,
         dentist,
         department_store,
         electronics_store,
         bank,
         hair_care,
         hospital,
         mosque,
         museum,
         parking,
         pharmacy,
         real_estate_agency,
         shopping_mall,
         spa,
         car_rental,
         car_repair,
         stadium
    
    var title : String {
        switch self {
        case .cafe:
            return "Coffee Shops"
        case .burger:
            return "Burgers"
        case .pizza:
            return "Pizza"
        case .sushi:
            return "Sushi"
        case .food:
            return "Restaurant"
        case .gym:
            return "Gym"
        case .bank:
            return "Bank"
        case .beauty_salon:
            return "Beauty Salon"
        case .car_rental:
            return "Car Rental"
        case .car_repair:
            return "Car Repair"
        case .car_wash:
            return "Car Wash"
        case .dentist:
            return "Dentist"
        case .department_store:
            return "Department Shop"
        case .doctor:
            return "Doctor"
        case .electronics_store:
            return "Electronic Store"
        case .florist:
            return "Flowers"
        case .gas_station:
            return "Petrol Station"
        case .hair_care:
            return "Barber"
        case .hospital:
            return "Hospital"
        case .mosque:
            return "Mosque"
        case .museum:
            return "Museum"
        case .parking:
            return "Parking"
        case .pharmacy:
            return "Pharmacy"
        case .real_estate_agency:
            return "Real Estate"
        case .shopping_mall:
            return "Shopping Mall"
        case .spa:
            return "SPA"
        case .stadium:
            return "Stadium"
        case .supermarket:
            return "Super market"
        case .tourist_attraction:
            return "Tourist Attraction"
        }
    }
    
    var apiName : String {
        switch self {
        case .cafe:
            return "coffee_shop"
        case .food:
            return "restaurant"
        case .burger:
            return "hamburger_restaurant"
        case .pizza:
            return "pizza_restaurant"
        case .sushi:
            return "sushi_restaurant"
        case .gym:
            return "gym"
        case .bank:
            return "bank"
        case .beauty_salon:
            return "beauty_salon"
        case .car_rental:
            return "car_rental"
        case .car_repair:
            return "car_repair"
        case .car_wash:
            return "car_wash"
        case .dentist:
            return "dentist"
        case .department_store:
            return "department_store"
        case .doctor:
            return "doctor"
        case .electronics_store:
            return "electronics_store"
        case .florist:
            return "florist"
        case .gas_station:
            return "gas_station"
        case .hair_care:
            return "hair_salon"
        case .hospital:
            return "hospital"
        case .mosque:
            return "mosque"
        case .museum:
            return "museum"
        case .parking:
            return "parking"
        case .pharmacy:
            return "pharmacy"
        case .real_estate_agency:
            return "real_estate_agency"
        case .shopping_mall:
            return "shopping_mall"
        case .spa:
            return "spa"
        case .stadium:
            return "stadium"
        case .supermarket:
            return "supermarket"
        case .tourist_attraction:
            return "tourist_attraction"
            
        }
    }
    
}
