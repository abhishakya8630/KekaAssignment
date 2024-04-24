//
//  ArticleService.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 24/04/24.
//

import Foundation

// MARK: - ArticleServiceProtocol
protocol ArticleServiceProtocol {
    func fetchArticles(completion: @escaping (Result<NYTAPIResponse, GenericError>) -> Void)
}

// MARK: - ArticleService
final class ArticleService: ArticleServiceProtocol {
    
    // MARK: - Properties
    private let networkService: NetworkService
    
    // MARK: - Initialization
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Fetch Articles
    func fetchArticles(completion: @escaping (Result<NYTAPIResponse, GenericError>) -> Void) {
        guard let requestURL = makeRequestURL() else {
            completion(.failure(.urlCreationError))
            return
        }
        
        let huRequest = HURequest(withUrl: requestURL, forHttpMethod: .get)
        networkService.executeRequest(request: huRequest, responseType: NYTAPIResponse.self) { result in
            completion(result)
        }
    }
    
    // MARK: - Helper Method to Create Request URL
    private func makeRequestURL() -> URL? {
        guard let requestURL = SearchArticalRequestModel(election: AppConstants.ApiKeyValue.election, apiKey: AppConstants.ApiKeyValue.apiKey)
            .toURL(scheme: RequestScheme.https.rawValue, withBaseURL: BaseURL.dataList.rawValue, endpoint: EndPoints.dataList.rawValue) else {
            return nil
        }
        return requestURL
    }
}
