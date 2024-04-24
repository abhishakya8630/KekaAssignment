//
//  DataSourceFactory.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 24/04/24.
//

import Foundation

// MARK: - DataSourceFactoryProtocol
protocol DataSourceFactoryProtocol {
    func getDataSource() -> DataSource
}

// MARK: - DataSourceFactory
final class DataSourceFactory: DataSourceFactoryProtocol {
    // MARK: - Properties
    private let networkDataSource: DataSource
    private let localDataSource: DataSource

    // MARK: - Initialization
    init(networkDataSource: DataSource, localDataSource: DataSource) {
        self.networkDataSource = networkDataSource
        self.localDataSource = localDataSource
    }

    // MARK: - Get DataSource
    func getDataSource() -> DataSource {
        return NetworkManager.shared.isConnectedToNetwork() ? networkDataSource : localDataSource
    }
}
