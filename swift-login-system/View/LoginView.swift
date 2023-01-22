//
//  LoginView.swift
//  swift-login-system
//
//  Created by Khater on 1/21/23.
//

import UIKit
import FacebookLogin
import GoogleSignIn

@objc protocol LoginViewDelegate: AnyObject {
    @objc func forgotPasswordButtonPressed()
    @objc func signInButtonPressed()
    @objc func facebookButtonPressed()
    @objc func googleButtonPressed()
    @objc func createAccountButtonPresssed()
}

class LoginView: UIView {
    
    // MARK: - Variables
    private weak var delegate: LoginViewDelegate!
    
    public var email: String {
        return emailTextField.text ?? ""
    }
    
    public var password: String {
        return passwordTextField.text ?? ""
    }
    
    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let headerView = CustomHeaderView(title: "Sign In", subTitle: "Sign in to your account")
    private let emailTextField = CustomTextField(textFieldType: .email)
    private let passwordTextField = CustomTextField(textFieldType: .password)
    
    private lazy var forgotPasswordButton: CustomButton = {
        let button = CustomButton(title: "Forgot Password?", fontSize: .small)
        button.addTarget(delegate, action: #selector(delegate.forgotPasswordButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .label
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private lazy var signInButton: CustomButton = {
        let button = CustomButton(title: "Sign In", hasBackground: true, fontSize: .medium)
        button.addTarget(delegate, action: #selector(delegate.signInButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var facebookSignInButton: FBLoginButton = {
        let button = FBLoginButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(delegate, action: #selector(delegate.facebookButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var googleSignInButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(delegate, action: #selector(delegate.googleButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var createAccountButton: CustomButton = {
        let button = CustomButton(title: "Don't have account? Create Account", fontSize: .small)
        button.addTarget(delegate, action: #selector(delegate.createAccountButtonPresssed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    init(delegate: LoginViewDelegate, facebookDeleage: LoginButtonDelegate, facebookPermissions: [String]){
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        
        self.delegate = delegate
        self.facebookSignInButton.delegate = facebookDeleage
        self.facebookSignInButton.permissions = facebookPermissions
        
        [emailTextField, passwordTextField].forEach { textField in
            textField.delegate = self
        }
        
        addSubviews()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        // This will make fatal error if we try to use This View in storyboard
        fatalError("init(coder:) has not been implemented")
        
        // If we want to use This View in stroyboard (This View Support everything)
        //super.init(coder: coder)
    }
    
    
    
    // MARK: - AddSubviews
    private func addSubviews(){
        self.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(headerView)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(forgotPasswordButton)
        containerView.addSubview(loadingIndicator)
        containerView.addSubview(signInButton)
        containerView.addSubview(facebookSignInButton)
        containerView.addSubview(googleSignInButton)
        containerView.addSubview(createAccountButton)
    }
    
    
    
    // MARK: - LayoutUI
    private func layoutUI() {
        setupScrollViewConstraints()
        setupContainerViewConstraints()
        setupHeaderViewConstraints()
        setupEmailTextFieldConstraints()
        setupPasswordTextFieldConstraints()
        setupForgotPasswordButtonConstraints()
        setupLoadingIndicatorConstraints()
        setupSignInButtonConstraints()
        setupFacebookButtonConstraints()
        setupGoogleButtonConstraints()
        setupCreateAccountButtonConstraints()
    }
    
    private func setupScrollViewConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupContainerViewConstraints(){
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    private func setupHeaderViewConstraints(){
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
        ])
    }
    
    private func setupEmailTextFieldConstraints(){
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            emailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            emailTextField.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
    private func setupPasswordTextFieldConstraints(){
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
    private func setupForgotPasswordButtonConstraints(){
        NSLayoutConstraint.activate([
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
        ])
    }
    
    private func setupLoadingIndicatorConstraints(){
        NSLayoutConstraint.activate([
            loadingIndicator.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 26),
            loadingIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    
    private func setupSignInButtonConstraints(){
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
            signInButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            signInButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            signInButton.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
    private func setupFacebookButtonConstraints(){
        NSLayoutConstraint.activate([
            facebookSignInButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 24),
            facebookSignInButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            facebookSignInButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    
    private func setupGoogleButtonConstraints(){
        NSLayoutConstraint.activate([
            googleSignInButton.topAnchor.constraint(equalTo: facebookSignInButton.bottomAnchor, constant: 18),
            googleSignInButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            googleSignInButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    
    private func setupCreateAccountButtonConstraints(){
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(greaterThanOrEqualTo: googleSignInButton.bottomAnchor, constant: 30),
            createAccountButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            createAccountButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
        ])
    }
    
    
    
    
    // MARK: - UpadteUI Functions
    public func enabaleViews(_ enable: Bool){
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
}



// MARK: - UITextField Delegate
extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField:
            passwordTextField.becomeFirstResponder()
            
        case passwordTextField:
            textField.endEditing(true)
            
        default: break
        }
        return true
    }
}
