//
//  CustomTextField.swift
//  swift-login-system
//
//  Created by Khater on 1/17/23.
//

import UIKit

class CustomTextField: UITextField {
    
    enum CustomTextFieldType {
        case name
        case username
        case email
        case password
    }
    
    private let textFieldType: CustomTextFieldType
    
    init(textFieldType: CustomTextFieldType){
        self.textFieldType = textFieldType
        super.init(frame: .zero)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.returnKeyType = .done
        
        switch textFieldType {
        case .name:
            self.textContentType = .name
            self.placeholder = "Name"
            
        case .username:
            self.textContentType = .username
            self.placeholder = "Username"
            
        case .email:
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
            self.placeholder = "Email Address"
            
        case .password:
            self.isSecureTextEntry = true
            // oneTimeCode: Security Code AutoFill
            self.textContentType = .oneTimeCode
            self.placeholder = "Password"
        }
        
        // Adding space in left of the textField
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
    }
}
