//
//  ForgotPasswordViewController.swift
//  swift-login-system
//
//  Created by Khater on 1/18/23.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Forgot Password", subTitle: "Reset your password")
    private let emailTextField = CustomTextField(textFieldType: .email)
    private let resetButton = CustomButton(title: "Reset Password", hasBackground: true, fontSize: .medium)
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Check your email, Password Reset Sent."
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
    }
    
    
    // MARK: - UI Setup
    private func setupUI(){
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.isHidden = false
        
        self.view.addSubview(headerView)
        self.view.addSubview(emailTextField)
        self.view.addSubview(resetButton)
        self.view.addSubview(messageLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30),
            headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            // Email TextField
            emailTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 22),
            emailTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),
            emailTextField.heightAnchor.constraint(equalToConstant: 55),
            
            // Reset Button
            resetButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
            resetButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            resetButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),
            resetButton.heightAnchor.constraint(equalToConstant: 55),
            
            // Message Label
            messageLabel.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 16),
            messageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            messageLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85),
        ])
    }
    
    
    // MARK: - Sections
    @objc func resetButtonPressed(){
        guard let email = emailTextField.text, !email.isEmpty else { return }
        
        // TODO: - Email Validation
        
        messageLabel.isHidden = false
    }
}
