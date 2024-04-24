//
//  HURequest.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 01/04/24.
//

import Foundation

protocol Request {
    var url: URL { get set }
    var method: HUHttpMethods { get set }
}

public struct HURequest : Request {
    var url: URL
    var method: HUHttpMethods
    var requestBody: Data? = nil

    public init(withUrl url: URL, forHttpMethod method: HUHttpMethods, requestBody: Data? = nil) {
        self.url = url
        self.method = method
        self.requestBody = requestBody != nil ? requestBody : nil
    }
}
