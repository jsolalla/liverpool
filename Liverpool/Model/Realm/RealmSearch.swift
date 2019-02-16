//
//  RealmSearch.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import Foundation
import RealmSwift

class RealmSearch: Object {
    
    @objc dynamic var term: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var created: Date = Date()
    
    override static func primaryKey() -> String? {
        return "term"
    }
    
}
