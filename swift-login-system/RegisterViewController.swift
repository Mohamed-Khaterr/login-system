//
//  RegisterViewController.swift
//  swift-login-system
//
//  Created by Khater on 1/17/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Sign Up", subTitle: "Create your account")
    
    private let nameTextField = CustomTextField(textFieldType: .name)
    private let usernameTextField = CustomTextField(textFieldType: .username)
    private let emailTextField = CustomTextField(textFieldType: .email)
    private let passwordTextField = CustomTextField(textFieldType: .password)
    
    private let signUpButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .medium)
    private let signInButton = CustomButton(title: "Already have an account? Sign In", fontSize: .small)
    
    private let termsTextView: UITextView = {
        // Make text with Links
        let attributedString = NSMutableAttributedString(string: "By creating an account you agree to our Terms & Conditions and you acknowledge that you have read our Privacy Policy.")
        // Add Link to text
        attributedString.addAttribute(.link, value: "https://policies.google.com/terms?h1=en", range: (attributedString.string as NSString).range(of: "Terms & Conditions"))
        attributedString.addAttribute(.link, value: "https://policies.google.com/privacy?h1=en", range: (attributedString.string as NSString).range(of: "Privacy Policy"))
        
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .label
        textView.isSelectable = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        // Add text with links to TextView
        textView.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        textView.attributedText = attributedString
        
        return textView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        
        termsTextView.delegate = self
    }
    
    // MARK: - UI Setup
    private func setupUI(){
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(headerView)
        self.view.addSubview(nameTextField)
        self.view.addSubview(usernameTextField)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(signUpButton)
        self.view.addSubview(termsTextView)
        self.view.addSubview(signInButton)
        
        // translatesAutoresizingMaskIntoConstraints: to set my constraints
        // default (true) is fully specify the view’s size and position
        // so i need to make it false to apply my constraints
        headerView.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        termsTextView.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Header View
            headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant:    180),
            
            // Name TextField
            nameTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            nameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            nameTextField.heightAnchor.constraint(equalToConstant: 55),
            
            // Username TextField
            usernameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            usernameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            usernameTextField.heightAnchor.constraint(equalToConstant: 55),
            
            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            emailTextField.heightAnchor.constraint(equalToConstant: 55),
            
            // Password TextField
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55),
            
            // SignUp Button
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            signUpButton.heightAnchor.constraint(equalToConstant: 55),
            
            // Terms TextView
            termsTextView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor),
            termsTextView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            termsTextView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            
            // SignIn Button
            signInButton.topAnchor.constraint(equalTo: termsTextView.bottomAnchor, constant: 12),
            signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
    
    
    // MARK: - Selectors
    @objc private func signUpButtonPressed(){
        let nav = UINavigationController(rootViewController: HomeViewController())
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .crossDissolve
        self.present(nav, animated: true, completion: nil)
    }
    
    @objc private func signInButtonPressed(){
        self.navigationController?.popToRootViewController(animated: true)
    }
}



// MARK: - UITextView Delegate
extension RegisterViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        showWebViewer(with: URL.absoluteURL)
        return false
    }
    
    private func showWebViewer(with url: URL){
        let webVC = WebViewController(with: url)
        let nav = UINavigationController(rootViewController: webVC)
        self.present(nav, animated: true, completion: nil)
    }
}
