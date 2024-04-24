//
//  LocationErrorDisplayView.swift
//  MotiveAssignment
//
//  Created by Abhishek Shakya on 01/04/24.
//

import Foundation
import UIKit

final class ErrorDisplayView: UIView {
    
    // MARK: - Constants
    private enum LayoutConstants {
        static let imageDimension: CGFloat = 300.0
        static let edgePadding: CGFloat = 16.0
    }
    
    // MARK: - Subviews
    private lazy var errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var errorTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var errorSubTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16.0, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    private func setupSubviews() {
        [errorImageView, errorTitleLabel, errorSubTitleLabel].forEach { addSubview($0) }
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            errorImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: LayoutConstants.edgePadding),
            errorImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorImageView.heightAnchor.constraint(equalToConstant: LayoutConstants.imageDimension),
            errorImageView.widthAnchor.constraint(equalToConstant: LayoutConstants.imageDimension),
            
            errorTitleLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: LayoutConstants.edgePadding),
            errorTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstants.edgePadding),
            errorTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutConstants.edgePadding),
            
            errorSubTitleLabel.topAnchor.constraint(equalTo: errorTitleLabel.bottomAnchor, constant: LayoutConstants.edgePadding),
            errorSubTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: LayoutConstants.edgePadding),
            errorSubTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -LayoutConstants.edgePadding),
            errorSubTitleLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -LayoutConstants.edgePadding)
        ])
        
    }
    
    // MARK: - Configuration
    func configureErrorView(withTitle title: String?, subTitle: String, imageName: String? = nil) {
        errorTitleLabel.text = title
        errorSubTitleLabel.text = subTitle
        if let imageName = imageName {
            errorImageView.image = UIImage(named: imageName)
        }
    }
}

