//
//  LiverpoolService.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire

class ServerTrustPoliceManager: ServerTrustPolicyManager {
    
    public init() {
        super.init(policies: [:])
    }
    
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return .disableEvaluation
    }
    
}

class LiverpoolService {
    
    static let current = LiverpoolService()
    
    public lazy var service: LiverpoolMoyaProvider = { [weak self] in
        
        let endpointClosure = { (target: LiverpoolEndpoint) -> Endpoint in
            return MoyaProvider.defaultEndpointMapping(for: target)
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15
        
        let manager = Manager(configuration: configuration, serverTrustPolicyManager: ServerTrustPoliceManager())
        let provider = LiverpoolMoyaProvider(endpointClosure: endpointClosure, manager: manager)
        
        return provider
    }()
    
}

class LiverpoolMoyaProvider {
    
    fileprivate let provider: MoyaProvider<LiverpoolEndpoint>
    
    init(endpointClosure: @escaping MoyaProvider<LiverpoolEndpoint>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
         stubClosure: @escaping MoyaProvider<LiverpoolEndpoint>.StubClosure = MoyaProvider.neverStub,
         manager: Manager = MoyaProvider<LiverpoolEndpoint>.defaultAlamofireManager(),
         plugins: [PluginType] = [NetworkLoggerPlugin(verbose: true)],
         trackInflights: Bool = false) {
        self.provider = MoyaProvider<LiverpoolEndpoint>(endpointClosure: endpointClosure, stubClosure: stubClosure, callbackQueue: nil, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }
    
    func request(_ token: LiverpoolEndpoint, isSecondTryAfterAuth: Bool = false) -> Single<Moya.Response> {
        return provider.rx.request(token)
    }
    
}
