//
//  LiverpoolEndpoint.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import Foundation
import Moya

private let GET_ENCODING: ParameterEncoding = URLEncoding.queryString
private let POST_ENCODING: ParameterEncoding = JSONEncoding.prettyPrinted

enum LiverpoolEndpoint {
    
    case search(term: String)
    
}

extension LiverpoolEndpoint: TargetType {
    
    var baseURL: URL {
        return WalmartEndpointConfig.current.baseURL
    }
    
    var path: String {
        
        switch self {
        case .search:
            return "tienda"
        }
        
    }
    
    var method: Moya.Method  {
        
        switch self {
        case .search:
            return .get
        }
        
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        
        switch self {
        case .search(let term):
            
            return .requestParameters(parameters:
                [Params.search: term,
                 Params.key: "json"], encoding: GET_ENCODING)
        }
        
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
