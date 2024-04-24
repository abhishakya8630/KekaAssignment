//
//  SearchArticalRequestModel.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 23/04/24.
//

import Foundation

struct SearchArticalRequestModel: Encodable {
    let election: String
    let apiKey: String

    enum CodingKeys: String, CodingKey {
        case election = "q"
        case apiKey = "api-key"
    }
}
