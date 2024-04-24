//
//  KekaHeadLineDataModel.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 23/04/24.
//

import Foundation

struct NYTAPIResponse: Codable {
    let response: NYTDocuments
}

struct NYTDocuments: Codable {
    let docs: [NYTDocument]
}

struct NYTDocument: Codable {
    let description: String?
    let titleData: NYTheadline?
    let pubDate: String?
    let multimedia: [NYTMultimedia]?
    
    enum CodingKeys: String, CodingKey {
        case description = "abstract"
        case titleData = "headline", multimedia
        case pubDate = "pub_date"
    }
}

struct NYTheadline: Codable {
    let title: String
    enum CodingKeys: String, CodingKey {
        case title = "main"
    }
}

struct NYTMultimedia: Codable {
    let url: String
    var fullURL: URL? {
        return URL(string: "https://www.nytimes.com/\(url)")
    }
}
