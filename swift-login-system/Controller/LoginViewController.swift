//
//  LoginViewController.swift
//  swift-login-system
//
//  Created by Khater on 1/17/23.
//

import UIKit
import FacebookCore
import FacebookLogin

class LoginViewController: UIViewController {

    // MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Sign In", subTitle: "Sign in to your account")
    
    private let emailTextField = CustomTextField(textFieldType: .email)
    private let passwordTextField = CustomTextField(textFieldType: .password)
    
    private let forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)
    private let signInButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .medium)
//    private let facebookSignInButton = CustomButton(title: "Facebook", iconName: "facebookLogo", fontSize: .medium)
    private let facebookSignInButton = FBLoginButton(frame: .zero, permissions: [.publicProfile])
    private let googleSignInButton = CustomButton(title: "Google", iconName: "googleLogo", fontSize: .medium)
    private let appleSignInButton = CustomButton(title: "Apple", iconName: "appleLogo", fontSize: .medium)
    private let createAccountButton = CustomButton(title: "Don't have account? Create Account", fontSize: .small)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        facebookSignInButton.addTarget(self, action: #selector(facebookButtonPressed), for: .touchUpInside)
        googleSignInButton.addTarget(self, action: #selector(googleButtonPressed), for: .touchUpInside)
        appleSignInButton.addTarget(self, action: #selector(appleButtonPressed), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonPressed), for: .touchUpInside)
        
        if let accessToken = AccessToken.current {
            print("Token:", accessToken)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    // MARK: - UI Setup
    private func setupUI(){
        self.view.backgroundColor = .systemBackground
        self.navigationItem.title = "Sign In"
        
        self.view.addSubview(headerView)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(forgotPasswordButton)
        self.view.addSubview(signInButton)
        self.view.addSubview(facebookSignInButton)
        self.view.addSubview(googleSignInButton)
        self.view.addSubview(appleSignInButton)
        self.view.addSubview(createAccountButton)
        
        // translatesAutoresizingMaskIntoConstraints: to set my constraints
        // default (true) is fully specify the view’s size and position
        // so i need to make it false to apply my constraints
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        facebookSignInButton.translatesAutoresizingMaskIntoConstraints = false
        googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        appleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Header View
            headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            emailTextField.heightAnchor.constraint(equalToConstant: 55),
            
            // Password TextField
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55),
            
            // ForgotPassword Button
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            // SignIn Button
            signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
            signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            signInButton.heightAnchor.constraint(equalToConstant: 55),
            
            // Facebook Button
            facebookSignInButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 24),
            facebookSignInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.25),
            facebookSignInButton.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
//            facebookSignInButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Apple Button
            appleSignInButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 18),
            appleSignInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.25),
            appleSignInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            appleSignInButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Google Button
            googleSignInButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 18),
            googleSignInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.25),
            googleSignInButton.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor),
            googleSignInButton.heightAnchor.constraint(equalToConstant: 40),
            
            // CreateAccount Button
            createAccountButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -12),
            createAccountButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
    
    
    // MARK: - Selectors
    @objc private func forgotPasswordButtonPressed(){
        navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
    
    @objc private func signInButtonPressed(){
        print("Sing In")
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            AlertManager.show(to: self, withTitle: "Empty Field!", andMessage: "Please fill all fields,\nand Try Again.")
            return
        }
        
        let user = LoginUserRequest(email: email, password: password)
        
        // TODO: - Fix Loading Alert
        //AlertManager.showAlertWithLoadingIndicator(to: self)
        
        AuthService.shared.singIn(with: user) { [weak self] error in
            guard let self = self else { return }
            
            //AlertManager.hideAlertWithLoadingIndicator()
            
            if let error = error {
                AlertManager.show(to: self, withTitle: "Sign In Error", andMessage: error.localizedDescription, returnKey: "Dismiss")
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.goToRootVC()
            }
        }
    }
    
    @objc private func facebookButtonPressed(){
        print("facebookButtonPressed")
    }
    
    @objc private func appleButtonPressed(){
        print("appleButtonPressed")
    }
    
    @objc private func googleButtonPressed(){
        print("googleButtonPressed")
    }
    
    @objc private func createAccountButtonPressed(){
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}
