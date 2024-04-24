//
//  SearchArticleCellVM.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 23/04/24.
//

import Foundation

final class SearchArticleCellVM {
    let title: String?
    let desc: String?
    let date: String?
    let image: URL?
    let sortDate: Date?  // Used for sorting
    
    init(from document: NYTDocument) {
        self.title = document.titleData?.title
        self.desc = document.description
        self.date = CommonResources.formatDate(document.pubDate)
        self.image = document.multimedia?.first?.fullURL
        self.sortDate = CommonResources.parseDate(document.pubDate)
    }
}
