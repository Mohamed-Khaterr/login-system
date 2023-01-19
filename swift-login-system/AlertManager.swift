//
//  AlertManager.swift
//  swift-login-system
//
//  Created by Khater on 1/19/23.
//

import Foundation
import UIKit


struct AlertManager {
    
    private static var alertWithLoadingIndicator: UIAlertController? = nil
    
    private init() {}
    
    static func show(to vc: UIViewController, withTitle title: String? = nil, andMessage message: String, returnKey: String? = nil){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title ?? "Woops!", message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: returnKey ?? "OK", style: .cancel, handler: nil)
            alert.addAction(alertAction)
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showAlertWithLoadingIndicator(to vc: UIViewController){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Loading", message: "Please wait...", preferredStyle: .alert)
            alert.view.tintColor = UIColor.black
            let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = .medium
            loadingIndicator.startAnimating();
            
            alert.view.addSubview(loadingIndicator)
            self.alertWithLoadingIndicator = alert
            vc.present(alert, animated: true)
        }
    }
    
    static func hideAlertWithLoadingIndicator(){
        DispatchQueue.main.async {
            if let alert = self.alertWithLoadingIndicator {
                alert.dismiss(animated: true, completion: nil)
                self.alertWithLoadingIndicator = nil
            }
        }
    }
}
