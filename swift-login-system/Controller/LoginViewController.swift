//
//  LoginViewController.swift
//  swift-login-system
//
//  Created by Khater on 1/17/23.
//

import UIKit
import FBSDKLoginKit
import FacebookLogin
import GoogleSignIn
import FirebaseAuth

class LoginViewController: UIViewController {

    // MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Sign In", subTitle: "Sign in to your account")
    
    private let emailTextField = CustomTextField(textFieldType: .email)
    private let passwordTextField = CustomTextField(textFieldType: .password)
    
    private let forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small)
    private let signInButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: .medium)
//    private let facebookSignInButton = CustomButton(title: "Facebook", iconName: "facebookLogo", fontSize: .medium)
    private let facebookSignInButton = FBLoginButton()
//    private let googleSignInButton = CustomButton(title: "Google", iconName: "googleLogo", fontSize: .medium)
    private let googleSignInButton = GIDSignInButton(frame: .zero)
    private let appleSignInButton = CustomButton(title: "Apple", iconName: "appleLogo", fontSize: .medium)
    private let createAccountButton = CustomButton(title: "Don't have account? Create Account", fontSize: .small)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonPressed), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        googleSignInButton.addTarget(self, action: #selector(googleButtonPressed), for: .touchUpInside)
        appleSignInButton.addTarget(self, action: #selector(appleButtonPressed), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(createAccountButtonPressed), for: .touchUpInside)
        
        appleSignInButton.isHidden = true
        
        facebookSignInButton.permissions = ["public_profile", "email"]
        facebookSignInButton.delegate = self
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
            facebookSignInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            facebookSignInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            facebookSignInButton.leadingAnchor.constraint(equalTo: signInButton.leadingAnchor),
            
            // Apple Button
            appleSignInButton.topAnchor.constraint(equalTo: googleSignInButton.bottomAnchor, constant: 18),
            appleSignInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.25),
            appleSignInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            appleSignInButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Google Button
            googleSignInButton.topAnchor.constraint(equalTo: facebookSignInButton.bottomAnchor, constant: 18),
            googleSignInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            googleSignInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            googleSignInButton.trailingAnchor.constraint(equalTo: signInButton.trailingAnchor),
            
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
    
    @objc private func appleButtonPressed(){
        print("appleButtonPressed")
    }
    
    @objc private func googleButtonPressed(){
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] signInResult, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Google Sign In error:", error.localizedDescription)
                return
            }
            
            guard
                let user = signInResult?.user,
                let idToken = user.idToken
            else { return }
            
            let accessToken = user.accessToken
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            
            AuthService.shared.otheProviderSignIn(credential: credential) { success, error in
                if let error = error {
                    print(error)
                    return
                }
                
                if success {
                    if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                        sceneDelegate.goToRootVC()
                    }
                }
            }
        }
    }
    
    @objc private func createAccountButtonPressed(){
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
}


// MARK: - FacebookSignInButton Delegate
extension LoginViewController: LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print("Facebook SignIn error:", error)
            return
        }
        
        guard let accessToken = result?.token else { return }
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
        
//        print(AccessToken.current)
        AuthService.shared.otheProviderSignIn(credential: credential) { success, error in
            if let error = error {
                print(error)
                return
            }

            if success {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.goToRootVC()
                }
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
}
