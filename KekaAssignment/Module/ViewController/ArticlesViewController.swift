//
//  ArticlesViewController.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 23/04/24.
//

import Foundation
import UIKit

// MARK: - ArticlesViewController
final class ArticlesViewController: UIViewController {
    
    //MARK: - Properties
    private var viewModel: ArticalDetailsVMProtocol
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    private lazy var dividerView: UIView = {
        let dividerView = UIView()
        dividerView.layer.backgroundColor = UIColor.gray.cgColor
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        return dividerView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 110.0
        tableView.separatorStyle = .singleLine
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var errorDisplayView: ErrorDisplayView = {
        let errorsView = ErrorDisplayView()
        errorsView.translatesAutoresizingMaskIntoConstraints = false
        return errorsView
    }()
    
    //MARK: - Initialization
    init(viewModel: ArticalDetailsVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        registerTableViewCells()
        viewModel.getArticleData()
    }
    
    //MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .gray
        self.title = AppConstants.Constants.appTitle
        layoutUIComponents()
    }
    
    //MARK: - UI Components
    private func layoutUIComponents() {
        
        let subviews = [activityIndicator, tableView, errorDisplayView, dividerView]
        subviews.forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            
            errorDisplayView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            errorDisplayView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            dividerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1.0),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        activityIndicator.isHidden = false
        errorDisplayView.isHidden = true
    }
    
    private func registerTableViewCells() {
        tableView.register(ArticleTableViewCell.self, forCellReuseIdentifier: ArticleTableViewCell.reuseIdentifier)
    }
}


//MARK: - UITableViewDelegate, UITableViewDataSource
extension ArticlesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = viewModel.cellModel(for: indexPath.row),
              let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier, for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(with: cellModel)
        return cell
    }
}

//MARK: - LocationDetailsVMDelegate
extension ArticlesViewController: ArticalDetailsVMDelegate {
    func showLoader() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.tableView.isHidden = true
            self.errorDisplayView.isHidden = true
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    func showErrorView(errorTitle: String, errorSubTitle: String) {
        DispatchQueue.main.async {
            self.errorDisplayView.isHidden = false
            self.tableView.isHidden = true
            self.errorDisplayView.configureErrorView(withTitle: errorTitle, subTitle: errorSubTitle, imageName: AppConstants.IconNames.errorIcon)
        }
    }
}

