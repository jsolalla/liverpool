//
//  SearchViewModel.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import Foundation
import RxSwift

class SearchViewModel {
    
    private let searchRepository: LiverpoolSearchRepository
    private let disposeBag: DisposeBag
    
    let products = Variable<[SearchRecord]>([])
    let isLoading = Variable<Bool>(false)
    let message = Variable<String>("")
    
    required init() {
        searchRepository = SearchRepository()
        disposeBag = DisposeBag.init()
    }
    
    func search(term: String) {
        
        isLoading.value = true
        searchRepository.search(for: term).bind { [weak self] (resultSearch) in
            
            self?.isLoading.value = false
            
            if case .error(let error) = resultSearch {
                self?.message.value = error.localizedDescription
            }
            
            if case .success(let search) = resultSearch {
                
                let records = search.getRecords()
                
                self?.products.value = records
                
                if let product = records.first {
                    self?.searchRepository.save(term: term, image: product.image)
                } else {
                    self?.message.value = "No se encontraron productos para \(term)"
                }

            }
            
        }.disposed(by: disposeBag)
    }
    
}
