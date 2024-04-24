//
//  CommonUtility.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 23/04/24.
//

import Foundation
class CommonResources {
    static func formatDate(_ dateString: String?) -> String? {
          guard let dateString = dateString else { return nil }
          let inputFormatter = DateFormatter()
          inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // or whatever your date format is
          if let date = inputFormatter.date(from: dateString) {
              let outputFormatter = DateFormatter()
              outputFormatter.dateFormat = "d-MMMM-yyyy"
              return outputFormatter.string(from: date)
          }
          return nil
      }
    
     static func parseDate(_ dateString: String?) -> Date? {
          guard let dateString = dateString else { return nil }
          let formatter = DateFormatter()
          formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
          return formatter.date(from: dateString)
      }
}
