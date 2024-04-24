//
//  ArticleEntity+CoreDataProperties.swift
//  KekaAssignment
//
//  Created by Abhishek Shakya on 24/04/24.
//
//

import Foundation
import CoreData


extension ArticleEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ArticleEntity> {
        return NSFetchRequest<ArticleEntity>(entityName: "ArticleEntity")
    }
    
    @NSManaged public var responseData: Data?
}

extension ArticleEntity : Identifiable {
    
}
