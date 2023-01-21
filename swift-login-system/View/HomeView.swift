//
//  HomeView.swift
//  swift-login-system
//
//  Created by Khater on 1/21/23.
//

import UIKit

class HomeView: UIView {
    
    // MARK: - UI Components
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        imageView.tintColor = .clear
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
        return imageView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .medium
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        return activityIndicator
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.text = "Loading..."
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Loading..."
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Loading..."
        return label
    }()
    
    
    // MARK: - LifeCycle
    init(){
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
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
        self.addSubview(profileImageView)
        self.addSubview(loadingIndicator)
        self.addSubview(nameLabel)
        self.addSubview(usernameLabel)
        self.addSubview(emailLabel)
    }
    
    
    
    // MARK: - LayoutUI
    private func layoutUI() {
        setupProfileImageViewConstraints()
        setupLoadingIndicatorConstraints()
        setupNameLabelConstraints()
        setupUsernameLabelConstraints()
        setupEmailLabelConstraints()
    }
    
    private func setupProfileImageViewConstraints(){
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            profileImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
        ])
    }
    
    private func setupLoadingIndicatorConstraints(){
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
        ])
    }
    
    private func setupNameLabelConstraints(){
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    private func setupUsernameLabelConstraints(){
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            usernameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    private func setupEmailLabelConstraints(){
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            emailLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    
    
    // MARK: - UpdateUI Functions
    public func startLoadingIndicatore(){
        loadingIndicator.startAnimating()
    }
    
    public func stopLoadingIndicatore(){
        loadingIndicator.stopAnimating()
    }

    public func setProfileImage(with image: UIImage?){
        profileImageView.image = image
    }
    
    public func setNameLabel(with text: String){
        nameLabel.text = text
    }
    
    public func setUsernameLabel(with text: String){
        usernameLabel.text = text
    }
    
    public func setEmailLabel(with text: String){
        emailLabel.text = text
    }
    
}
