//
//  SearchRepository.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import Foundation
import RxSwift
import Mapper

protocol LiverpoolSearchRepository {
    func search(for term: String) -> Observable<APIResult<Search>>
}

class SearchRepository: BaseRepository, LiverpoolSearchRepository {
    
    /// Generic observable API connection for Search related endpoints
    fileprivate func observable(searchEnpoint: LiverpoolEndpoint) -> Observable<APIResult<Search>> {
        
        return Observable.create { [weak self] observer in
            
            if let strongSelf = self {
                
                _ = strongSelf.provider.request(searchEnpoint)
                    .filterSuccessfulStatusCodes()
                    .map(to: [Search].self, keyPath: "contents")
                    .subscribe { event in
                        switch event {
                        case .success(let searchInfo):
                            
                            if let search = searchInfo.first {
                                observer.onNext(APIResult.success(search))
                                observer.onCompleted()
                            } else {
                                observer.onNext(APIResult.error(strongSelf.getError(for: "Couldn't get search")))
                                observer.onCompleted()
                            }
                            
                        case .error(let error):
                            observer.onNext(APIResult.error(error))
                            observer.onCompleted()
                        }
                }
            }
            
            return Disposables.create()
        }
    }
    
    func search(for term: String) -> Observable<APIResult<Search>> {
        return observable(searchEnpoint: .search(term: term))
    }
    
}
