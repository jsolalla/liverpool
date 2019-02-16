//
//  BaseRepository.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RealmSwift
import Mapper
import Moya_ModelMapper

class BaseRepository {
    
    let provider: LiverpoolMoyaProvider
    let realm: Realm
    let disposeBag: DisposeBag
    
    required init() {
        provider = LiverpoolService.current.service
        disposeBag = DisposeBag.init()
        realm = try! Realm()
    }
    
    /**
     API request for liverpool
     
     - Parameter endpoint: Liverpool Moya endpoint.
     - Returns: An Observable with proper validation for APIResult
     */
    func observable<T: Mappable>(endpoint: LiverpoolEndpoint) -> Observable<APIResult<T>> {
        return Observable.create { [weak self] observer in
            
            if let weakSelf = self {
                _ = weakSelf.provider.request(endpoint)
                    .filterSuccessfulStatusCodes()
                    .map(to: T.self)
                    .subscribe { event in
                        switch event {
                        case .success(let response):
                            observer.onNext(APIResult.success(response))
                            observer.onCompleted()
                        case .error(let error):
                            observer.onNext(APIResult.error(error))
                            observer.onCompleted()
                        }
                }
            }
            
            return Disposables.create()
        }
    }
    
    /**
     Gets a custom error based on the given message
     
     - Parameter message: The error message
     - Returns: Custom error
     */
    func getError(for message: String) -> Error {
        return NSError(domain: Constants.defaultErrorKey, code: 888, userInfo: [NSLocalizedDescriptionKey: message]) as Error
    }
    
}
