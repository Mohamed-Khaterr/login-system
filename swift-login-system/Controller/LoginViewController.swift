//
//  LoginViewController.swift
//  swift-login-system
//
//  Created by Khater on 1/17/23.
//

import UIKit
import FacebookLogin
import GoogleSignIn

class LoginViewController: UIViewController {

    // MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Sign In", subTitle: "Sign in to your account")
    private let emailTextField = CustomTextField(textFieldType: .email)
    private let passwordTextField = CustomTextField(textFieldType: .password)
    private let forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)
    private let signInButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .medium)
    private let facebookSignInButton = FBLoginButton()
    private let googleSignInButton = GIDSignInButton(frame: .zero)
    private let createAccountButton = CustomButton(title: "Don't have account? Create Account", fontSize: .small)
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = .label
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        facebookSignInButton.permissions = ["email", "public_profile"]
        facebookSignInButton.delegate = self
        
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        facebookSignInButton.addTarget(self, action: #selector(facebookButtonPressed), for: .touchUpInside)
        googleSignInButton.addTarget(self, action: #selector(googleButtonPressed), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonPressed), for: .touchUpInside)
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
        self.view.addSubview(loadingIndicator)
        self.view.addSubview(signInButton)
        self.view.addSubview(facebookSignInButton)
        self.view.addSubview(googleSignInButton)
        self.view.addSubview(createAccountButton)
        
        // translatesAutoresizingMaskIntoConstraints: to set my constraints
        // default (true) is fully specify the view’s size and position
        // so i need to make it false to apply my constraints
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        facebookSignInButton.translatesAutoresizingMaskIntoConstraints = false
        googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
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
            
            // Loading Indicator
            loadingIndicator.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 26),
            loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // SignIn Button
            signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
            signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            signInButton.heightAnchor.constraint(equalToConstant: 55),
            
            // Facebook Button
            facebookSignInButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 24),
            facebookSignInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            facebookSignInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // Google Button
            googleSignInButton.topAnchor.constraint(equalTo: facebookSignInButton.bottomAnchor, constant: 18),
            googleSignInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            googleSignInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            // CreateAccount Button
            createAccountButton.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor, constant: -12),
            createAccountButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
    
    private func enabaleViews(_ enable: Bool){
        DispatchQueue.main.async {
            self.emailTextField.isEnabled = enable
            self.passwordTextField.isEnabled = enable
            self.forgotPasswordButton.isEnabled = enable
            self.signInButton.isEnabled = enable
            self.facebookSignInButton.isEnabled = enable
            self.googleSignInButton.isEnabled = enable
            self.createAccountButton.isEnabled = enable
            
            
            if !enable {
                self.loadingIndicator.startAnimating()
                UIView.animate(withDuration: 0.5) {
                    self.signInButton.transform.ty = 34
                    self.facebookSignInButton.transform.ty = 28
                    self.googleSignInButton.transform.ty = 28
                }
            }else{
                self.loadingIndicator.stopAnimating()
                UIView.animate(withDuration: 0.3) {
                    self.signInButton.transform = .identity
                    self.facebookSignInButton.transform = .identity
                    self.googleSignInButton.transform = .identity
                }
            }
            
        }
    }
    
    
    // MARK: - Selectors
    @objc private func forgotPasswordButtonPressed(){
        navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
    }
    
    @objc private func signInButtonPressed(){
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            AlertManager.show(to: self, withTitle: "Sign In", andMessage: "Please fill all fields,\nand Try Again.")
            return
        }
        
        // Email Check
        if !Validator.isValidEmail(for: email.lowercased()){
            AlertManager.show(to: self, withTitle: "Invalid Email", andMessage: "Email is not valid,\nTry Again.")
            return
        }
        
        enabaleViews(false)
        
        let user = LoginUserRequest(email: email.lowercased(),
                                    password: password)
        
        AuthService.shared.singIn(withUser: user) { [weak self] error in
            guard let self = self else { return }
            self.enabaleViews(true)
            if let error = error {
                AlertManager.show(to: self, withTitle: "Sign In", andMessage: error.localizedDescription, returnKey: "Dismiss")
                return
            }

            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.goToRootVC()
            }
        }
    }
    
    @objc private func facebookButtonPressed(){
        enabaleViews(false)
    }
    
    
    @objc private func googleButtonPressed(){
        enabaleViews(false)
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] signInResult, error in
            guard let self = self else { return }
            self.enabaleViews(true)
            
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
    
    @objc private func createAccountButtonPressed(){
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
}


// MARK: - FacebookSignInButton Delegate
extension LoginViewController: LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            AlertManager.show(to: self, withTitle: "Facebook Login", andMessage: error.localizedDescription, returnKey: "Dismiss")
            return
        }
        
        guard let accessToken = result?.token else { return }
        
        AuthService.shared.signIn(withProvidere: .facebook(accessToken: accessToken.tokenString)) { [weak self] signInSuccess, error in
            guard let self = self else { return }
            self.enabaleViews(true)
            
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
