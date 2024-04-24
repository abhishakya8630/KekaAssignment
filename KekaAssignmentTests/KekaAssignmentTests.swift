//
//  KekaAssignmentTests.swift
//  KekaAssignmentTests
//
//  Created by Abhishek Shakya on 23/04/24.
//

import XCTest
@testable import KekaAssignment

final class CryptoCoinsViewModelTests: XCTestCase {
    var viewModel: ArticalDetailsViewModel!
    var mockRepository: ArticleRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = ArticleRepository()
        viewModel = ArticalDetailsViewModel(articleRepo: mockRepository)
    }
    
    override func tearDown() {
        viewModel = nil
        mockRepository = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadDataSuccessfully() {
        viewModel.getArticleData()
        XCTAssertEqual(viewModel.getTotalNumberOfListData(), 1)
    }
    
    func testLoadDataFailure() {
        mockRepository.jsonFileName = "ArticleFailureData"
        viewModel.getArticleData()
        XCTAssertEqual(viewModel.getTotalNumberOfListData(), 0)
    }
}

class ArticleRepository: ArticleRepositoryProtocol {
    var jsonFileName: String = "ArticleData"
    func fetchArticles(completion: @escaping (Result<NYTAPIResponse?, GenericError>) -> Void) {
        guard let jsonData = fetchJsonFrom(jsonFileName: jsonFileName) else {
            completion(.failure(.emptyJsonData))
            return
        }
        let jsonDecoder = JSONDecoder()
        do {
            let decodedData = try jsonDecoder.decode(NYTAPIResponse.self, from: jsonData)
            completion(.success(decodedData))
        } catch(let error) {
            completion(.failure(.customError(reason: error.localizedDescription)))
        }
    }
    
    // Assuming this function is correctly placed in this mock or another utility class
    fileprivate func fetchJsonFrom(jsonFileName: String) -> Data? {
        if let path =  Bundle(for: type(of: self)).path(forResource: jsonFileName, ofType: "json") {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                return data
            }
        }
        return nil
    }
}

