//
//  AuthHeaderView.swift
//  swift-login-system
//
//  Created by Khater on 1/17/23.
//

import UIKit

class AuthHeaderView: UIView {
    
    // MARK: - UI Components
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        imageView.tintColor = .clear
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.text = "Error"
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    
    // MARK: - LifeCycle
    init(title: String, subTitle: String){
        super.init(frame: .zero)
        
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.addSubview(logoImageView)
        self.addSubview(titleLabel)
        self.addSubview(subTitleLabel)
        
        // translatesAutoresizingMaskIntoConstraints: to set my constraints
        // default (true) is fully specify the view’s size and position
        // so i need to make it false to apply my constraints
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Logo
            self.logoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.logoImageView.widthAnchor.constraint(equalToConstant: 90),
            self.logoImageView.heightAnchor.constraint(equalTo: self.logoImageView.widthAnchor),
            
            // Title
            self.titleLabel.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 16),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            // SubTitle
            self.subTitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            self.subTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.subTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
