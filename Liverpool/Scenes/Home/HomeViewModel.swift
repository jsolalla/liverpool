//
//  HomeViewModel.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    private let homeRepository: LiverpoolHomeRepository
    
    let terms = Variable<[RealmSearch]>([])
    
    required init() {
        homeRepository = HomeRepository()
        updateTerms()
    }
    
    func updateTerms() {
        terms.value = homeRepository.getSearchTerms()
    }
    
}
