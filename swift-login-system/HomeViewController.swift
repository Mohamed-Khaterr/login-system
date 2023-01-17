//
//  HomeViewController.swift
//  swift-login-system
//
//  Created by Khater on 1/17/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - UI Components
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "logo")
        imageView.tintColor = .clear
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.text = "Error"
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // TODO: - Set Name & Email
    }
    
    
    // MARK: - UI Setup
    private func setupUI(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(logoutButtonPressed))
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.backgroundColor = .secondarySystemBackground
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(logoImageView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(emailLabel)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30),
            logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            logoImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            
            nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            emailLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
    
    
    // MARK: - Sections
    @objc private func logoutButtonPressed(){
        // TODO: - Logout from Firebase
        self.dismiss(animated: true, completion: nil)
    }
}
