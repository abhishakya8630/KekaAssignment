//
//  ArticleStorageService.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 24/04/24.
//

import Foundation
import CoreData

// MARK: - ArticleStorageProtocol
protocol ArticleStorageProtocol {
    func fetchArticles(completion: @escaping (Result<NYTAPIResponse, GenericError>) -> Void)
    func saveArticles(_ articles: NYTAPIResponse)
}

// MARK: - ArticleCoreDataStorage
final class ArticleCoreDataStorage: ArticleStorageProtocol {
    
    // MARK: - Fetch Articles
    func fetchArticles(completion: @escaping (Result<NYTAPIResponse, GenericError>) -> Void) {
        let context = PersistentStorage.shared.persistentContainer.newBackgroundContext()
        context.perform {
            let request: NSFetchRequest<ArticleEntity> = ArticleEntity.fetchRequest()
            do {
                let results = try context.fetch(request)
                if let responseData = results.first?.responseData {
                    let articles = try JSONDecoder().decode(NYTAPIResponse.self, from: responseData)
                    DispatchQueue.main.async {
                        completion(.success(articles))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(.decodingError))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
            }
        }
    }
    
    // MARK: - Save Articles
    func saveArticles(_ articles: NYTAPIResponse) {
        let context = PersistentStorage.shared.persistentContainer.newBackgroundContext()
        context.perform {
            do {
                let jsonData = try JSONEncoder().encode(articles)
                let newArticleEntity = ArticleEntity(context: context)
                newArticleEntity.responseData = jsonData
                try context.save()
            } catch {
                print("Error saving articles: \(error)")
            }
        }
    }
}
