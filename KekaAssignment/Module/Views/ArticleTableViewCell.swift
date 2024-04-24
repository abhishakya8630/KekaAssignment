//
//  ArticleTableViewCell.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 23/04/24.
//

import Foundation
import UIKit

// MARK: - ArticleTableViewCell
class ArticleTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    private struct Constants {
        static let imageHeight: CGFloat = 320.0
        static let defaultPadding: CGFloat = 10.0
    }
    
    // MARK: - UI Elements
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font =  UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title2).pointSize)
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var articleImageView: LazyImageView = {
        let imageView = LazyImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Reuse Identifier
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    // MARK: - Setup UI Elements
    private func setupViews() {
        [titleLabel, descriptionLabel, dateLabel, articleImageView].forEach(contentView.addSubview)
        setupConstraints()
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.defaultPadding),
            articleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.defaultPadding),
            articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.defaultPadding),
            articleImageView.heightAnchor.constraint(equalToConstant: Constants.imageHeight),
            
            titleLabel.topAnchor.constraint(equalTo: articleImageView.bottomAnchor, constant: Constants.defaultPadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.defaultPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.defaultPadding),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.defaultPadding),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.defaultPadding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.defaultPadding),

            dateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.defaultPadding),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.defaultPadding),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.defaultPadding),
            dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -Constants.defaultPadding)
        ])
    }

    // MARK: - Configure Cell
    func configure(with viewModel: SearchArticleCellVM) {
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.desc
        dateLabel.text = viewModel.date
        if let imageUrl = viewModel.image {
            articleImageView.loadImage(fromURL: imageUrl, placeHolderImage: "placeholder")
        } else {
            articleImageView.image = UIImage(named: "placeholder")
        }
    }
}
