//
//  HomeRepository.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import Foundation
import RxSwift
import Mapper

protocol LiverpoolHomeRepository {
    func getSearchTerms() -> [RealmSearch]
}

class HomeRepository: BaseRepository, LiverpoolHomeRepository {
    
    func getSearchTerms() -> [RealmSearch] {
        return Array(realm.objects(RealmSearch.self).sorted(byKeyPath: "created", ascending: false))
    }
    
}
