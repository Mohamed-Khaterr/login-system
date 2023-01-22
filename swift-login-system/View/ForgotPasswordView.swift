//
//  ForgotPasswordView.swift
//  swift-login-system
//
//  Created by Khater on 1/22/23.
//

import UIKit

@objc protocol ForgotPasswordViewDelegate: AnyObject {
    @objc func resetButtonPressed()
}

class ForgotPasswordView: UIView {
    // MARK: - Variables
    private weak var delegate: ForgotPasswordViewDelegate!
    
    public var email: String {
        return emailTextField.text ?? ""
    }
    
    
    // MARK: - UI Components
    private let headerView = CustomHeaderView(title: "Forgot Password", subTitle: "Reset your password")
    private let emailTextField = CustomTextField(textFieldType: .email)
    
    private lazy var resetButton: CustomButton = {
        let button = CustomButton(title: "Reset Password", hasBackground: true, fontSize: .medium)
        button.addTarget(delegate, action: #selector(delegate.resetButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Check your email, Password Reset Sent."
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    
    // MARK: - LifeCycle
    init(delegate: ForgotPasswordViewDelegate){
        super.init(frame: .zero)
        backgroundColor = .systemBackground
        self.delegate = delegate
        emailTextField.delegate = self
        
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
        addSubview(headerView)
        addSubview(emailTextField)
        addSubview(messageLabel)
        addSubview(resetButton)
    }
    
    
    
    // MARK: - LayoutUI
    private func layoutUI() {
        setupHeaderViewConstraints()
        setupEmailTextFieldConstraints()
        setupMessageLabelConstraints()
        setupResetButtonConstraints()
    }
    
    private func setupHeaderViewConstraints(){
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
        ])
    }
    
    private func setupEmailTextFieldConstraints(){
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 22),
            emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            emailTextField.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
    private func setupMessageLabelConstraints(){
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            messageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            messageLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
        ])
    }
    
    private func setupResetButtonConstraints(){
        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
            resetButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            resetButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85),
            resetButton.heightAnchor.constraint(equalToConstant: 55),
        ])
    }
    
    
    
    // MARK: - UpdateUI Functions
    public func updateUI(){
        DispatchQueue.main.async {
            self.messageLabel.layer.opacity = 0
            UIView.animate(withDuration: 0.5) {
                self.messageLabel.isHidden = false
                self.resetButton.transform.ty = self.messageLabel.frame.size.height + 24
            } completion: { _ in
                UIView.animate(withDuration: 0.35) {
                    self.messageLabel.layer.opacity = 1
                }
            }
        }
    }
}


// MARK: - UITextField Delegate
extension ForgotPasswordView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
