//
//  SearchProductTableViewCell.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import UIKit
import Nuke

class SearchProductTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblDisplayName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ product: SearchRecord) {
     
        if let imageUrl = URL(string: product.image) {
            Nuke.loadImage(with: imageUrl, options: Constants.defaultNukeOptions, into: imgProduct)
        }
        
        lblDisplayName.text = product.displayName
        lblPrice.text = product.price.toCurrency()
    }
    
}
