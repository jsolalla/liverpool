//
//  String+Extensions.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2018 jsolalla. All rights reserved.
//

import UIKit

extension String {

    /// Returns the string as Double
    func toDouble() -> Double {
        return Double(self) ?? 0.0
    }
    
}
