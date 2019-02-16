//
//  UIViewController+Extensions.swift
//  Liverpool
//
//  Created by Jesus Santa Olalla on 2/16/19.
//  Copyright © 2018 jsolalla. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension UISearchController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension UISearchContainerViewController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}


public extension UIViewController {
    
    func showAsyncActivityIndicator(in view: UIView, completion: @escaping (_ activityView: UIView) -> Void) {
        
        let indicatorView = UIView()
        indicatorView.frame = view.frame
        indicatorView.center = view.center
        indicatorView.backgroundColor = .clear
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = .black
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        actInd.style = .whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        
        loadingView.addSubview(actInd)
        indicatorView.addSubview(loadingView)
        actInd.startAnimating()
        
        view.addSubview(indicatorView)
        completion(indicatorView)
    }
    
    func setUpNavigationBar(_ title: String, prefersLargeTitles: Bool = true) {
        
        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationController?.navigationBar.topItem?.title = title
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.main
        navigationController?.view.backgroundColor = UIColor.main
        navigationController?.navigationBar.tintColor = UIColor.white
        
        if #available(iOS 11.0, *), prefersLargeTitles {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
        
    }
    
    func showAlert(_ title: String = "Liverpool", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
