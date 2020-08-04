//
//  BaseViewController.swift
//  GoDreamVoyage
//
//  Created by Nathan on 04/08/2020.
//  Copyright © 2020 Nathan. All rights reserved.
//

import Foundation
class BaseViewController: UIViewController {
    
    private var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
        
    }
    @IBOutlet weak var convertButton: UIButton!
    
    private func setupLoadingIndicator() {
        activityIndicatorView = UIActivityIndicatorView()
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func changeLoadingIndicatorVisibility(shouldShow: Bool) {
        if shouldShow {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

}
