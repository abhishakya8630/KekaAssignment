//
//  ArticleSaveHandler.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 24/04/24.
//

import Foundation

protocol ArticleFetchCompletionHandler {
    func handleFetchResult(_ result: Result<NYTAPIResponse, GenericError>)
}

final class ArticleSaveHandler: ArticleFetchCompletionHandler {
    // MARK: - Properties
    private let storage: ArticleStorageProtocol

    // MARK: - Initialization
    init(storage: ArticleStorageProtocol) {
        self.storage = storage
    }

    // MARK: - Handle Fetch Result
    func handleFetchResult(_ result: Result<NYTAPIResponse, GenericError>) {
        switch result {
        case .success(let response):
            storage.saveArticles(response)
        case .failure(let error):
            debugPrint("Error fetching articles: \(error)")
        }
    }
}
