//
//  LoginController.swift
//  swift-login-system
//
//  Created by Khater on 1/17/23.
//

import UIKit
import FacebookLogin
import GoogleSignIn

class LoginController: UIViewController {
    
    // MARK: - UI Components
    private lazy var mainView = LoginView(delegate: self, facebookDeleage: self, facebookPermissions: ["email", "public_profile"])

    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "Sign In"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}


// MARK: - LoginView Delegate
extension LoginController: LoginViewDelegate {
    func forgotPasswordButtonPressed() {
        navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
    
    func signInButtonPressed() {
        let email = mainView.email
        let password = mainView.password
        
        guard !email.isEmpty, !password.isEmpty else {
            AlertManager.show(to: self, withTitle: "Sign In", andMessage: "Please fill all fields,\nand Try Again.")
            return
        }
        
        // Email Check
        if !Validator.isValidEmail(for: email.lowercased()){
            AlertManager.show(to: self, withTitle: "Invalid Email", andMessage: "Email is not valid,\nTry Again.")
            return
        }
        
        mainView.enabaleViews(false)
        
        let user = LoginUserRequest(email: email.lowercased(),
                                    password: password)
        
        AuthService.shared.singIn(withUser: user) { [weak self] error in
            guard let self = self else { return }
            self.mainView.enabaleViews(true)
            if let error = error {
                AlertManager.show(to: self, withTitle: "Sign In", andMessage: error.localizedDescription, returnKey: "Dismiss")
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.goToRootVC()
            }
        }
    }
    
    func facebookButtonPressed() {
        mainView.enabaleViews(false)
    }
    
    func googleButtonPressed() {
        mainView.enabaleViews(false)
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] signInResult, error in
            guard let self = self else { return }
            self.mainView.enabaleViews(true)
            
            if let error = error {
                AlertManager.show(to: self, withTitle: "Google Sign In", andMessage: error.localizedDescription, returnKey: "Dismiss")
                return
            }
            
            guard
                let user = signInResult?.user,
                let idToken = user.idToken
            else { return }
            
            let accessToken = user.accessToken
            
            AuthService.shared.signIn(withProvidere: .google(idToken: idToken.tokenString, accessToken: accessToken.tokenString)) { signInSuccess, error in
                if let error = error {
                    AlertManager.show(to: self, withTitle: "Google Sign In", andMessage: error.localizedDescription, returnKey: "Dismiss")
                    return
                }
                
                if signInSuccess {
                    if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                        sceneDelegate.goToRootVC()
                    }
                }
            }
        }
    }
    
    func createAccountButtonPresssed() {
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}


// MARK: - FacebookSignInButton Delegate
extension LoginController: LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            AlertManager.show(to: self, withTitle: "Facebook Login", andMessage: error.localizedDescription, returnKey: "Dismiss")
            return
        }

        guard let accessToken = result?.token else { return }

        AuthService.shared.signIn(withProvidere: .facebook(accessToken: accessToken.tokenString)) { [weak self] signInSuccess, error in
            guard let self = self else { return }
            self.mainView.enabaleViews(true)

            if let error = error {
                AlertManager.show(to: self, withTitle: "Facebook Login", andMessage: error.localizedDescription, returnKey: "Dismiss")
                return
            }

            if signInSuccess {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.goToRootVC()
                }
            }
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
    }
}
