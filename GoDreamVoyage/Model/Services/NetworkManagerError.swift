//
//  NetworkManagerError.swift
//  GoDreamVoyage
//
//  Created by Nathan on 30/06/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation

enum NetworkManagerError: Error {
    case invalidResponseStatusCode
    case unknownErrorOccured
    case noData
    case couldNotDecodeJson
    
    var message: String {
        switch self {
        case .invalidResponseStatusCode: return "Invalid Response Status Code"
        case .couldNotDecodeJson: return "Unable to decode JSON file"
        case .noData: return "No data received"
        default: return "Unknown error"
        }
    }
    
}
