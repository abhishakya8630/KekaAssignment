//
//  HeadLineRepository.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 23/04/24.
//

import Foundation

// MARK: - ArticleRepository Protocol
protocol ArticleRepositoryProtocol {
    func fetchArticles(completion: @escaping (Result<NYTAPIResponse?, GenericError>) -> Void)
}

// MARK: - SearchArticleRepository Class
class ArticleRepository: ArticleRepositoryProtocol {
    // MARK: - Properties
    private let dataSourceFactory: DataSourceFactoryProtocol
    private let completionHandler: ArticleFetchCompletionHandler

    // MARK: - Initialization
    init(dataSourceFactory: DataSourceFactoryProtocol, completionHandler: ArticleFetchCompletionHandler) {
        self.dataSourceFactory = dataSourceFactory
        self.completionHandler = completionHandler
    }

    // MARK: - Fetch Articles
    func fetchArticles(completion: @escaping (Result<NYTAPIResponse?, GenericError>) -> Void) {
        let dataSource = dataSourceFactory.getDataSource()
        dataSource.fetchArticles { [weak self] result in
            completion(result.map { $0 })
            self?.completionHandler.handleFetchResult(result)
        }
    }
}
