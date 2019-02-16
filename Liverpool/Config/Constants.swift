//
//  Constants.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import Foundation
import Nuke

struct Constants {
    
    static let defaultCellLoadImage = UIImage(named: "loading")
    static let defaultNukeOptions = ImageLoadingOptions(placeholder: Constants.defaultCellLoadImage, transition: .fadeIn(duration: 0.33))
    static let defaultErrorKey = "com.liverpool.service.error"
    static let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    static let showLogs = false
    
}
