//
//  LoginViewController.swift
//  swift-login-system
//
//  Created by Khater on 1/17/23.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Sign In", subTitle: "Sign in to your account")
    
    private let emailTextField = CustomTextField(textFieldType: .email)
    private let passwordTextField = CustomTextField(textFieldType: .password)
    
    private let forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)
    private let signInButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .medium)
    private let facebookSignInButton = CustomButton(title: "Facebook", iconName: "facebookLogo", fontSize: .medium)
    private let googleSignInButton = CustomButton(title: "Google", iconName: "googleLogo", fontSize: .medium)
    private let appleSignInButton = CustomButton(title: "Apple", iconName: "appleLogo", fontSize: .medium)
    private let createAccountButton = CustomButton(title: "Don't have account? Create Account", fontSize: .small)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        facebookSignInButton.addTarget(self, action: #selector(facebookButtonPressed), for: .touchUpInside)
        googleSignInButton.addTarget(self, action: #selector(googleButtonPressed), for: .touchUpInside)
        appleSignInButton.addTarget(self, action: #selector(appleButtonPressed), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonPressed), for: .touchUpInside)
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
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant:    180),
            
            // Email TextField
            self.emailTextField.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 16),
            self.emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.emailTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 55),
            
            // Password TextField
            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 16),
            self.passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.passwordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            self.passwordTextField.heightAnchor.constraint(equalToConstant: 55),
            
            // ForgotPassword Button
            self.forgotPasswordButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor),
            self.forgotPasswordButton.trailingAnchor.constraint(equalTo: self.passwordTextField.trailingAnchor),
            
            // SignIn Button
            self.signInButton.topAnchor.constraint(equalTo: self.forgotPasswordButton.bottomAnchor, constant: 24),
            self.signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.signInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            self.signInButton.heightAnchor.constraint(equalToConstant: 55),
            
            // Facebook Button
            self.facebookSignInButton.topAnchor.constraint(equalTo: self.signInButton.bottomAnchor, constant: 16),
            self.facebookSignInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            self.facebookSignInButton.leadingAnchor.constraint(equalTo: self.signInButton.leadingAnchor),
            self.facebookSignInButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Google Button
            self.googleSignInButton.topAnchor.constraint(equalTo: self.signInButton.bottomAnchor, constant: 16),
            self.googleSignInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            self.googleSignInButton.trailingAnchor.constraint(equalTo: self.signInButton.trailingAnchor),
            self.googleSignInButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Apple Button
            self.appleSignInButton.topAnchor.constraint(equalTo: self.signInButton.bottomAnchor, constant: 16),
            self.appleSignInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
            self.appleSignInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.appleSignInButton.heightAnchor.constraint(equalToConstant: 40),
            
            // CreateAccount Button
            self.createAccountButton.topAnchor.constraint(equalTo: self.googleSignInButton.bottomAnchor, constant: 12),
            self.createAccountButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
    
    
    // MARK: - Selectors
    @objc private func forgotPasswordButtonPressed(){
        navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
    
    @objc private func signInButtonPressed(){
        let nav = UINavigationController(rootViewController: HomeViewController())
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .crossDissolve
        self.present(nav, animated: true, completion: nil)
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
