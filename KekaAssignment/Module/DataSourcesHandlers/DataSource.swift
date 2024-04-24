//
//  NetworkDataSource.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 24/04/24.
//

import Foundation

// MARK: - DataSource Protocol
protocol DataSource {
    func fetchArticles(completion: @escaping (Result<NYTAPIResponse, GenericError>) -> Void)
}

// MARK: - NetworkDataSource
final class NetworkDataSource: DataSource {
    // MARK: - Properties
    private let service: ArticleServiceProtocol
    
    // MARK: - Initialization
    init(service: ArticleServiceProtocol) {
        self.service = service
    }
    
    // MARK: - Fetch Articles
    func fetchArticles(completion: @escaping (Result<NYTAPIResponse, GenericError>) -> Void) {
        service.fetchArticles(completion: completion)
    }
}

// MARK: - LocalDataSource
final class LocalDataSource: DataSource {
    // MARK: - Properties
    private let storage: ArticleStorageProtocol
    
    // MARK: - Initialization
    init(storage: ArticleStorageProtocol) {
        self.storage = storage
    }
    
    // MARK: - Fetch Articles
    func fetchArticles(completion: @escaping (Result<NYTAPIResponse, GenericError>) -> Void) {
        storage.fetchArticles(completion: completion)
    }
}
