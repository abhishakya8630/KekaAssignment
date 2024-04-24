//
//  HUNetworkError.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 01/04/24.
//

import Foundation

// Define the GenericError enum for handling different network errors
public enum GenericError: Error {
    case decodingError
    case encodingError
    case networkError
    case emptyJsonData
    case urlCreationError
    case customError(reason: String)
    
    var localizedDescription: String {
        switch self {
        case .encodingError:
            return "Encoding Error"
        case .decodingError:
            return "Decoding Error"
        case .emptyJsonData:
            return "Data Not Available"
        case .networkError:
            return "Network Error"
        case .urlCreationError:
            return "URL Creation Error"
        case .customError(let reason):
            return "Error: \(reason)"
        }
    }
}
