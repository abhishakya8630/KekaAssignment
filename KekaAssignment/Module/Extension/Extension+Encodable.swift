//
//  Extension + URL.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 23/04/24.
//

//MARK: GenericQueryParam

import Foundation

extension Encodable {
    /// Converts an Encodable object into a URL by appending an endpoint to a base URL, setting the scheme, and adding the object's properties as query parameters.
    /// - Parameters:
    ///   - baseURL: The base URL as a string.
    ///   - endpoint: The endpoint path to be appended to the base URL.
    ///   - scheme: The scheme (`http` or `https`) to be used for the URL.
    /// - Returns: An optional URL constructed from the scheme, base URL, endpoint, and the object's properties as query parameters. Returns `nil` if the URL could not be constructed or the object could not be encoded properly.
    func toURL(scheme: String, withBaseURL baseURL: String, endpoint: String) -> URL? {
        guard var components = URLComponents(string: baseURL) else {
            debugPrint("Invalid base URL: \(baseURL)")
            return nil
        }
        
        components.scheme = scheme
        components.path.append(contentsOf: endpoint)
        
        do {
            let queryItems = try toQueryItems()
            components.queryItems = queryItems.isEmpty ? nil : queryItems
        } catch {
            debugPrint("Failed to encode object to query items: \(error.localizedDescription)")
            return nil
        }
        
        return components.url
    }
    
    /// Encodes the object into an array of URLQueryItem.
    /// - Returns: An array of URLQueryItem representing the encoded object properties.
    /// - Throws: An error if encoding to JSON or serialization to a dictionary fails.
    private func toQueryItems() throws -> [URLQueryItem] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            throw GenericError.encodingError
        }
        
        return dictionary.compactMap { key, value -> URLQueryItem? in
            // Ensure the value is not nil and convert to a string representation
            guard let valueString = value as? CustomStringConvertible else { return nil }
            return URLQueryItem(name: key, value: valueString.description)
        }
    }
}
