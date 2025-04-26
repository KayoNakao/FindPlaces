//
//  File.swift
//  FindPlaces
//
//  Created by Kayo on 2025-04-25.
//

import Foundation

enum ResponseType {
    case informational, success, redirection, clientError, serverError, undefined
    
    static func get(statusCode: Int) -> ResponseType {
        
        switch statusCode {
        case 100..<200:
            print("DEBUG: informational")
            return .informational
        case 200..<300:
            print("DEBUG: successful request")
            return .success
        case 300..<400:
            print("DEBUG: redirection")
            return .redirection
        case 400..<500:
            print("DEBUG: bad request")
            return .clientError
        case 500..<600:
            print("DEBUG: server is wrong")
            return .serverError
        default:
            print("DEBUG: unknown status code")
            return .undefined
        }
    }
}
