//
//  NetworkService.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 01/04/24.
//

import Foundation
import Foundation

// MARK: - NetworkService Protocol
public protocol NetworkService {
    func executeRequest<T: Decodable>(request: HURequest, responseType: T.Type, completionHandler: @escaping (Result<T, GenericError>) -> Void)
}

// MARK: - DefaultNetworkService Class
final public class DefaultNetworkService: NetworkService {
    private let session: URLSession
    public var customJsonDecoder: JSONDecoder? = nil
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func executeRequest<T: Decodable>(request: HURequest, responseType: T.Type, completionHandler: @escaping (Result<T, GenericError>) -> Void) {
        switch request.method {
        case .get:
            getData(request: request, responseType: responseType, completionHandler: completionHandler)
        }
    }
    
    // MARK: - Private functions
    private func createJsonDecoder() -> JSONDecoder {
        let decoder = customJsonDecoder ?? JSONDecoder()
        if customJsonDecoder == nil {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }
    
    private func getData<T: Decodable>(request: HURequest, responseType: T.Type, completionHandler: @escaping (Result<T, GenericError>) -> Void) {
        let urlRequest = URLRequest(url: request.url)
        performDataTask(request: urlRequest, responseType: responseType, completionHandler: completionHandler)
    }
    
    private func performDataTask<T: Decodable>(request: URLRequest, responseType: T.Type, completionHandler: @escaping (Result<T, GenericError>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(.networkError))
                return
            }
            
            guard let data = data, error == nil else {
                completionHandler(.failure(.networkError))
                return
            }
            
            if (200...299).contains(httpUrlResponse.statusCode) {
                let response = self.decodeJsonResponse(data: data, responseType: responseType)
                if let responseData = response {
                    completionHandler(.success(responseData))
                } else {
                    completionHandler(.failure(.decodingError))
                }
            } else {
                completionHandler(.failure(.customError(reason: "HTTP status code: \(httpUrlResponse.statusCode)")))
            }
        }.resume()
    }
    
    private func decodeJsonResponse<T: Decodable>(data: Data, responseType: T.Type) -> T? {
        let decoder = createJsonDecoder()
        do {
            return try decoder.decode(responseType, from: data)
        } catch let error {
            print("Error while decoding JSON response: \(error.localizedDescription)")
        }
        return nil
    }
}
