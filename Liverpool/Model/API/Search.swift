//
//  Search.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import Foundation
import Mapper

class Search: Mappable {
    
    private var mainArea: [Area] = []
    
    required init(map: Mapper) throws {
        mainArea = (try? map.from("mainContent")) ?? []
    }
    
    fileprivate func getRecordsContent() -> Content? {
        
        for area in mainArea {
            if let recordsContent = area.contents.filter({ (content) -> Bool in
                return content.totalNumRecs > 0
            }).first {
                return recordsContent
            }
        }
        
        return nil
    }
    
    
    func getRecords() -> [SearchRecord] {
        
        if let recordsContent = getRecordsContent() {
            return recordsContent.records
        }
        
        return []
    }
    
}

class Area: Mappable {
    
    var name = ""
    var type = ""
    var contents: [Content] = []
    
    required init(map: Mapper) throws {
        type = (try? map.from("type")) ?? ""
        name = (try? map.from("name")) ?? ""
        contents = (try? map.from("contents")) ?? []
    }
    
}

class Content: Mappable {
    
    var firstRecNum = 0
    var lastRecNum = 0
    var recsPerPage = 0
    var totalNumRecs = 0
    var records: [SearchRecord] = []
    
    required init(map: Mapper) throws {
        firstRecNum = (try? map.from("firstRecNum")) ?? 0
        lastRecNum = (try? map.from("lastRecNum")) ?? 0
        recsPerPage = (try? map.from("recsPerPage")) ?? 0
        totalNumRecs = (try? map.from("totalNumRecs")) ?? 0
        records = (try? map.from("records")) ?? []
    }
    
}

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
