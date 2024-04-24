//
//  SearchArticleVM.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 23/04/24.
//

import Foundation

// MARK: - ArticalDetailsVMDelegate
protocol ArticalDetailsVMDelegate: AnyObject {
    func showLoader()
    func hideLoader()
    func reloadTable()
    func showErrorView(errorTitle: String, errorSubTitle: String)
}

// MARK: - ArticalDetailsVMProtocol
protocol ArticalDetailsVMProtocol {
    var delegate: ArticalDetailsVMDelegate? { get set }
    func getArticleData()
    func numberOfRows(in section: Int) -> Int
    func cellModel(for index: Int) -> SearchArticleCellVM?
    func getTotalNumberOfListData() -> Int
}

// MARK: - ArticalDetailsViewModel
final class ArticalDetailsViewModel: ArticalDetailsVMProtocol {
    
    private let articleRepo: ArticleRepositoryProtocol
    weak var delegate: ArticalDetailsVMDelegate?
    
    private var articleCellModelData: [SearchArticleCellVM] = []
    
    init(articleRepo: ArticleRepositoryProtocol) {
        self.articleRepo = articleRepo
    }
    
    //MARK: - Data Fetching
    func getArticleData() {
        self.delegate?.showLoader()
        articleRepo.fetchArticles { [weak self] result in
            guard let self = self else { return }
            self.delegate?.hideLoader()
            
            switch result {
            case .success(let success):
                let documents = success?.response.docs ?? []
                self.updateCellModels(data: documents)
                
            case .failure(let failure):
                debugPrint(failure.localizedDescription)
                self.delegate?.showErrorView(errorTitle: AppConstants.Constants.errorTitle,
                                             errorSubTitle: AppConstants.Constants.errorSubtitle)
            }
        }
    }
    
    //MARK: - Cell Model Handling
    private func updateCellModels(data: [NYTDocument]) {
        guard !data.isEmpty else {
            self.delegate?.showErrorView(errorTitle: AppConstants.Constants.noArticlesFoundTitle,
                                         errorSubTitle: AppConstants.Constants.noArticlesFoundSubtitle)
            return
        }
        
        let sortedData = data.sorted(by: {
            guard let date1 = $0.pubDate, let date2 = $1.pubDate else { return false }
            return date1 > date2 // Assuming `pubDate` is parsed to `Date` for comparison
        })
        
        self.articleCellModelData = sortedData.map { SearchArticleCellVM(from: $0) }
        self.delegate?.reloadTable()
    }
    
    //MARK: - Table View Data Source
    func numberOfRows(in section: Int) -> Int {
        return self.articleCellModelData.count
    }
    
    func cellModel(for index: Int) -> SearchArticleCellVM? {
        guard index < self.articleCellModelData.count else { return nil }
        return self.articleCellModelData[index]
    }
    
    func getTotalNumberOfListData() -> Int {
        return self.articleCellModelData.count
    }
}
