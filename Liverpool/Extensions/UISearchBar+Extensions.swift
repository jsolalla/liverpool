//
//  UISearchBar+Extensions.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import UIKit

public extension UISearchBar {
    
    public func setBackgroundColor(color: UIColor) {
        if let textfield = value(forKey: "searchField") as? UITextField {
            textfield.tintColor = UIColor.gray
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = color
                backgroundview.layer.cornerRadius = 10
                backgroundview.clipsToBounds = true
            }
        }
    }
    
}
