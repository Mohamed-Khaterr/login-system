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
    private let mainView = LoginView()

    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "Sign In"
        
//        facebookSignInButton.permissions = ["email", "public_profile"]
//        facebookSignInButton.delegate = self
//
//        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
//        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
//        facebookSignInButton.addTarget(self, action: #selector(facebookButtonPressed), for: .touchUpInside)
//        googleSignInButton.addTarget(self, action: #selector(googleButtonPressed), for: .touchUpInside)
//        createAccountButton.addTarget(self, action: #selector(createAccountButtonPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    // MARK: - Selectors
//    @objc private func forgotPasswordButtonPressed(){
//        navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
//    }
    
//    @objc private func signInButtonPressed(){
//        guard let email = emailTextField.text, !email.isEmpty,
//              let password = passwordTextField.text, !password.isEmpty
//        else {
//            AlertManager.show(to: self, withTitle: "Sign In", andMessage: "Please fill all fields,\nand Try Again.")
//            return
//        }
//
//        // Email Check
//        if !Validator.isValidEmail(for: email.lowercased()){
//            AlertManager.show(to: self, withTitle: "Invalid Email", andMessage: "Email is not valid,\nTry Again.")
//            return
//        }
//
//        enabaleViews(false)
//
//        let user = LoginUserRequest(email: email.lowercased(),
//                                    password: password)
//
//        AuthService.shared.singIn(withUser: user) { [weak self] error in
//            guard let self = self else { return }
//            self.enabaleViews(true)
//            if let error = error {
//                AlertManager.show(to: self, withTitle: "Sign In", andMessage: error.localizedDescription, returnKey: "Dismiss")
//                return
//            }
//
//            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
//                sceneDelegate.goToRootVC()
//            }
//        }
//    }
    
//    @objc private func facebookButtonPressed(){
//        enabaleViews(false)
//    }
    
    
//    @objc private func googleButtonPressed(){
//        enabaleViews(false)
//        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] signInResult, error in
//            guard let self = self else { return }
//            self.enabaleViews(true)
//
//            if let error = error {
//                AlertManager.show(to: self, withTitle: "Google Sign In", andMessage: error.localizedDescription, returnKey: "Dismiss")
//                return
//            }
//
//            guard
//                let user = signInResult?.user,
//                let idToken = user.idToken
//            else { return }
//
//            let accessToken = user.accessToken
//
//            AuthService.shared.signIn(withProvidere: .google(idToken: idToken.tokenString, accessToken: accessToken.tokenString)) { signInSuccess, error in
//                if let error = error {
//                    AlertManager.show(to: self, withTitle: "Google Sign In", andMessage: error.localizedDescription, returnKey: "Dismiss")
//                    return
//                }
//
//                if signInSuccess {
//                    if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
//                        sceneDelegate.goToRootVC()
//                    }
//                }
//            }
//        }
//    }
    
//    @objc private func createAccountButtonPressed(){
//        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
//    }
}


// MARK: - FacebookSignInButton Delegate
//extension LoginViewController: LoginButtonDelegate{
//    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
//        if let error = error {
//            AlertManager.show(to: self, withTitle: "Facebook Login", andMessage: error.localizedDescription, returnKey: "Dismiss")
//            return
//        }
//
//        guard let accessToken = result?.token else { return }
//
//        AuthService.shared.signIn(withProvidere: .facebook(accessToken: accessToken.tokenString)) { [weak self] signInSuccess, error in
//            guard let self = self else { return }
//            self.enabaleViews(true)
//
//            if let error = error {
//                AlertManager.show(to: self, withTitle: "Facebook Login", andMessage: error.localizedDescription, returnKey: "Dismiss")
//                return
//            }
//
//            if signInSuccess {
//                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
//                    sceneDelegate.goToRootVC()
//                }
//            }
//        }
//    }
//
//    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
//        print("Logout")
//    }
//}
