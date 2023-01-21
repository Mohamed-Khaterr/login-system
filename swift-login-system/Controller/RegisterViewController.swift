//
//  RegisterViewController.swift
//  swift-login-system
//
//  Created by Khater on 1/17/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
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
    
    private let headerView = AuthHeaderView(title: "Sign Up", subTitle: "Create your account")
    private let nameTextField = CustomTextField(textFieldType: .name)
    private let usernameTextField = CustomTextField(textFieldType: .username)
    private let emailTextField = CustomTextField(textFieldType: .email)
    private let passwordTextField = CustomTextField(textFieldType: .password)
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .label
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    private let signUpButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .medium)
    private let termsTextView: UITextView = {
        // Make text with Links
        let attributedString = NSMutableAttributedString(string: "By creating an account you agree to our Terms & Conditions and you acknowledge that you have read our Privacy Policy.")
        // Add Link to text
        attributedString.addAttribute(.link, value: "https://policies.google.com/terms?h1=en", range: (attributedString.string as NSString).range(of: "Terms & Conditions"))
        attributedString.addAttribute(.link, value: "https://policies.google.com/privacy?h1=en", range: (attributedString.string as NSString).range(of: "Privacy Policy"))
        
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
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
    
    private let signInButton = CustomButton(title: "Already have an account? Sign In", fontSize: .small)
    
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
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(headerView)
        containerView.addSubview(nameTextField)
        containerView.addSubview(usernameTextField)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(loadingIndicator)
        containerView.addSubview(signUpButton)
        containerView.addSubview(termsTextView)
        containerView.addSubview(signInButton)
        
        
        containerView.addSubview(headerView)
        containerView.addSubview(nameTextField)
        
        // translatesAutoresizingMaskIntoConstraints: to set my constraints
        // default (true) is fully specify the view’s size and position
        // so i need to make it false to apply my constraints
        headerView.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            // Scroll View
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            // Container View
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Header View
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),

            // Name TextField
            nameTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            nameTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8),
            nameTextField.heightAnchor.constraint(equalToConstant: 55),

            // Username TextField
            usernameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            usernameTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            usernameTextField.heightAnchor.constraint(equalToConstant: 55),

            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            emailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            emailTextField.heightAnchor.constraint(equalToConstant: 55),

            // Password TextField
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55),

            // Loading Indicator
            loadingIndicator.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 26),
            loadingIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),

            // SignUp Button
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            signUpButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            signUpButton.heightAnchor.constraint(equalToConstant: 55),

            // Terms TextView
            termsTextView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 24),
            termsTextView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            termsTextView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),

            // SignIn Button
            signInButton.topAnchor.constraint(greaterThanOrEqualTo: termsTextView.bottomAnchor, constant: 30),
            signInButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            signInButton.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -12),
        ])
    }
    
    
    private func enabaleViews(_ enable: Bool){
        DispatchQueue.main.async {
            self.nameTextField.isEnabled = enable
            self.usernameTextField.isEnabled = enable
            self.emailTextField.isEnabled = enable
            self.passwordTextField.isEnabled = enable
            
            self.signUpButton.isEnabled = enable
            self.signInButton.isEnabled = enable
            
            if !enable {
                self.loadingIndicator.startAnimating()
                UIView.animate(withDuration: 0.5) {
                    self.signUpButton.transform.ty = 34
                    self.termsTextView.transform.ty = 28
                }
            }else{
                self.loadingIndicator.stopAnimating()
                UIView.animate(withDuration: 0.3) {
                    self.signUpButton.transform = .identity
                    self.termsTextView.transform = .identity
                }
            }
            
        }
    }
    
    
    // MARK: - Selectors
    @objc private func signUpButtonPressed(){
        guard let name = nameTextField.text, !name.isEmpty,
              let username = usernameTextField.text, !username.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty
        else {
            AlertManager.show(to: self, withTitle: "Empty Field!", andMessage: "Please fill all fields,\nand Try Again.")
            return
        }

        // Username Check
        if !Validator.isValidUsername(for: username){
            AlertManager.show(to: self, withTitle: "Invalid Username", andMessage: "Username is not valid,\nTry Again.")
            return
        }

        // Email Check
        if !Validator.isValidEmail(for: email){
            AlertManager.show(to: self, withTitle: "Invalid Email", andMessage: "Email is not valid,\nTry Again.")
            return
        }

        // Password Check
        if !Validator.isPasswordValid(for: password) {
            AlertManager.show(to: self,
                              withTitle: "Invalid Password",
                              andMessage: "Password is not valid.\nMake sure that the password contains:\nMinimum 8 characters at least.\n1 Alphabet.\n1 Number.\n1 Special Character.")
            return
        }
        
        enabaleViews(false)
        let registerUser = RegisterUserRequest(name: name, username: username.lowercased(), email: email.lowercased(), password: password)

        AuthService.shared.registerUser(with: registerUser) { [weak self] success, error in
            guard let self = self else { return }
            self.enabaleViews(true)

            if let error = error {
                AlertManager.show(to: self, withTitle: "Server Error!", andMessage: error.localizedDescription)
                return
            }

            if success {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.goToRootVC()
                }
            }else{
                fatalError("False: register the user")
            }
        }
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
