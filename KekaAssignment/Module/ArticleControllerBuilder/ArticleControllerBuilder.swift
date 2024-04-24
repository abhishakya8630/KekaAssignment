//
//  ArticleControllerBuilder.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 24/04/24.
//

import Foundation
import UIKit

import UIKit

class ViewControllerBuilder {
    private var sceneWindow: UIWindowScene

    init(sceneWindow: UIWindowScene) {
        self.sceneWindow = sceneWindow
    }

    func buildNetworkService() -> NetworkService {
        return DefaultNetworkService()
    }

    func buildArticleService(networkService: NetworkService) -> ArticleService {
        return ArticleService(networkService: networkService)
    }

    func buildStorage() -> ArticleCoreDataStorage {
        return ArticleCoreDataStorage()
    }

    func buildNetworkDataSource(articleService: ArticleService) -> NetworkDataSource {
        return NetworkDataSource(service: articleService)
    }

    func buildLocalDataSource(storage: ArticleCoreDataStorage) -> LocalDataSource {
        return LocalDataSource(storage: storage)
    }

    func buildDataSourceFactory(networkDataSource: NetworkDataSource, localDataSource: LocalDataSource) -> DataSourceFactory {
        return DataSourceFactory(networkDataSource: networkDataSource, localDataSource: localDataSource)
    }

    func buildArticleSaveHandler(storage: ArticleCoreDataStorage) -> ArticleSaveHandler {
        return ArticleSaveHandler(storage: storage)
    }

    func buildArticleRepository(dataSourceFactory: DataSourceFactory, articleSaveHandler: ArticleSaveHandler) -> ArticleRepository {
        return ArticleRepository(dataSourceFactory: dataSourceFactory, completionHandler: articleSaveHandler)
    }

    func buildViewModel(articleRepository: ArticleRepository) -> ArticalDetailsViewModel {
        return ArticalDetailsViewModel(articleRepo: articleRepository)
    }

    func buildViewController(viewModel: ArticalDetailsViewModel) -> ArticlesViewController {
        return ArticlesViewController(viewModel: viewModel)
    }

    func build() -> UIViewController {
        let networkService = buildNetworkService()
        let articleService = buildArticleService(networkService: networkService)
        let storage = buildStorage()
        let networkDataSource = buildNetworkDataSource(articleService: articleService)
        let localDataSource = buildLocalDataSource(storage: storage)
        let dataSourceFactory = buildDataSourceFactory(networkDataSource: networkDataSource, localDataSource: localDataSource)
        let articleSaveHandler = buildArticleSaveHandler(storage: storage)
        let articleRepository = buildArticleRepository(dataSourceFactory: dataSourceFactory, articleSaveHandler: articleSaveHandler)
        let viewModel = buildViewModel(articleRepository: articleRepository)
        let viewController = buildViewController(viewModel: viewModel)
        return UINavigationController(rootViewController: viewController)
    }
}
