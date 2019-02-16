//
//  HomeViewController.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2019 jsolalla. All rights reserved.
//

import UIKit
import RxCocoa

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Liverpool"
    }
    
}
