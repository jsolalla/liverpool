//
//  SearchRecord.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import Foundation
import Mapper

class SearchRecord {
    
    var displayName = ""
    var image = ""
    var price = 0.0
    var location = ""
    
}

extension SearchRecord: Convertible {
    
    static func fromMap(_ value: Any) throws -> SearchRecord {
        
        guard let record = value as? [String: Any] else {
            throw MapperError.convertibleError(value: value, type: [String: Any].self)
        }
        
        let newRecord = SearchRecord()
        
        newRecord.image = (record["largeImage"] as? [String])?.first ?? ""
        newRecord.displayName = (record["productDisplayName"] as? [String])?.first ?? ""
        newRecord.price = (record["sku.salePrice"] as? [String])?.first?.toDouble() ?? 0.0
        
        return newRecord
    }
    
}
