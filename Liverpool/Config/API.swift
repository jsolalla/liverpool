//
//  API.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import Foundation

class WalmartEndpointConfig {
    
    private init() {
        
    }
    
    public static var current = WalmartEndpointConfig()
    
    public lazy var baseURL = URL(string: APIEndPointConfig.current.rawValue)!

}

public enum APIEndPointConfig: String, Equatable {
    
    case production = "https://www.liverpool.com.mx"
    
    // Could be any other URL to change the environment
    case development = "https://www.liverpool-qa.com.mx"
    
    public static var current: APIEndPointConfig {
        return .production
    }

}
