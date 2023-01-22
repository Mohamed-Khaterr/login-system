//
//  RegisterView.swift
//  swift-login-system
//
//  Created by Khater on 1/21/23.
//

import UIKit

@objc protocol RegisterViewDelegate: AnyObject {
    @objc func pickImageButtonPressed()
    @objc func signUpButtonPressed()
    @objc func termsTextViewPressed(urlString: String) -> Bool
    @objc func signInButtonPressed()
}


class RegisterView: UIView {
    
    // MARK: - Variables
    private weak var delegate: RegisterViewDelegate!
    
    public var profileImage: UIImage? {
        didSet{
            pickImageButton.setImage(profileImage, for: .normal)
            pickImageButton.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    public var name: String {
        return nameTextField.text ?? ""
    }
    
    public var username: String {
        return usernameTextField.text ?? ""
    }
    
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
    
    private let headerView = CustomHeaderView(title: "Sign Up", subTitle: "Create your account")
    
    private lazy var pickImageButton: CustomButton = {
        let button = CustomButton(title: "Choose Profile Image", fontSize: .small)
        button.addTarget(delegate, action: #selector(delegate.pickImageButtonPressed), for: .touchUpInside)
        return button
    }()
    
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
    
    private lazy var signUpButton: CustomButton = {
        let button = CustomButton(title: "Sign Up", hasBackground: true, fontSize: .medium)
        button.addTarget(delegate, action: #selector(delegate.signUpButtonPressed), for: .touchUpInside)
        return button
    }()
    
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
    
    private lazy var signInButton: CustomButton = {
        let button = CustomButton(title: "Already have an account? Sign In", fontSize: .small)
        button.addTarget(delegate, action: #selector(delegate.signInButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    init(delegate: RegisterViewDelegate){
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        self.delegate = delegate
        nameTextField.delegate = self
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        termsTextView.delegate = self
        
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
        containerView.addSubview(pickImageButton)
        containerView.addSubview(nameTextField)
        containerView.addSubview(usernameTextField)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(loadingIndicator)
        containerView.addSubview(signUpButton)
        containerView.addSubview(termsTextView)
        containerView.addSubview(signInButton)
    }
    
    
    // MARK: - LayoutUI
    private func layoutUI() {
        setupScrollViewConstraints()
        setupContainerViewConstraints()
        setupHeaderViewConstraints()
        setupPickImageButtonConstraints()
        setupNameTextFieldConstraints()
        setupUsernameTextFieldConstraints()
        setupEmailTextFieldConstraints()
        setupPasswrodTextFieldConstraints()
        setupLoadingIndicatorConstraints()
        setupSignUpButtonConstraints()
        setupTermsTextViewConstraints()
        setupSignInButtonConstraints()
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
    
    private func setupPickImageButtonConstraints() {
        NSLayoutConstraint.activate([
            pickImageButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 16),
            pickImageButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            pickImageButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            pickImageButton.heightAnchor.constraint(lessThanOrEqualToConstant: 55)
        ])
    }
    
    private func setupNameTextFieldConstraints(){
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: pickImageButton.bottomAnchor, constant: 16),
            nameTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            nameTextField.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
    private func setupUsernameTextFieldConstraints(){
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 16),
            usernameTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            usernameTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            usernameTextField.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
    private func setupEmailTextFieldConstraints(){
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 16),
            emailTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            emailTextField.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
    private func setupPasswrodTextFieldConstraints(){
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            passwordTextField.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
    private func setupLoadingIndicatorConstraints(){
        NSLayoutConstraint.activate([
            loadingIndicator.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 26),
            loadingIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        ])
    }
    
    private func setupSignUpButtonConstraints(){
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            signUpButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            signUpButton.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
    private func setupTermsTextViewConstraints(){
        NSLayoutConstraint.activate([
            termsTextView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 8),
            termsTextView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            termsTextView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
        ])
    }
    
    private func setupSignInButtonConstraints(){
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(greaterThanOrEqualTo: termsTextView.bottomAnchor, constant: 30),
            signInButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            signInButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
        ])
    }
    
    
    // MARK: - UpadteUI Functions
    public func enabaleViews(_ enable: Bool){
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
}



// MARK: - UITextView Delegate
extension RegisterView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return delegate.termsTextViewPressed(urlString: URL.absoluteString)
    }
}


// MARK: - UITextField Delegate
extension RegisterView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case nameTextField:
            usernameTextField.becomeFirstResponder()
            
        case usernameTextField:
            emailTextField.becomeFirstResponder()
            
        case emailTextField:
            passwordTextField.becomeFirstResponder()
            
        case passwordTextField:
            textField.endEditing(true)
            
        default: break
        }
        
        return true
    }
}
