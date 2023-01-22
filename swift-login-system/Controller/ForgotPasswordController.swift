//
//  ForgotPasswordController.swift
//  swift-login-system
//
//  Created by Khater on 1/18/23.
//

import UIKit

class ForgotPasswordController: UIViewController {
    
    // MARK: - UI Components
    private lazy var mainView = ForgotPasswordView(delegate: self)
    
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
    }
}


// MARK: - ForgotPassword Delegate
extension ForgotPasswordController: ForgotPasswordViewDelegate {
    func resetButtonPressed(){
        let email = mainView.email
        
        if !Validator.isValidEmail(for: email) {
            AlertManager.show(to: self, withTitle: "Invalid Email", andMessage: "Email is not valid,\nTry again with valid email.", returnKey: "OK")
            return
        }
        
        AuthService.shared.forgotPassword(withEmail: email) { [weak self] error in
            guard let self = self else { return }

            if let error = error {
                AlertManager.show(to: self, withTitle: "Forgot Password", andMessage: error.localizedDescription, returnKey: "Dismiss")
                return
            }

            self.mainView.updateUI()
        }
    }
}
