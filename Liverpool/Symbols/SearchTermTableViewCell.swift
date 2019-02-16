//
//  SearchTermTableViewCell.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import UIKit
import Nuke

class SearchTermTableViewCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblTerm: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ search: RealmSearch) {
        
        if let imageUrl = URL(string: search.image) {
            Nuke.loadImage(with: imageUrl, options: Constants.defaultNukeOptions, into: imgProduct)
        }
        
        lblTerm.text = search.term
    }
    
}
