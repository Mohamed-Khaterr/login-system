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
        label.text = "Loading..."
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "Loading..."
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Loading..."
        return label
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // TODO: - Set Name & Email
        AuthService.shared.fetchUser { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                AlertManager.show(to: self, withTitle: "User Info", andMessage: error.localizedDescription, returnKey: "Dismiss")
                
            case .success(let user):
                DispatchQueue.main.async {
                    self.nameLabel.text = user.name
                    self.usernameLabel.text = user.username
                    self.emailLabel.text = user.email
                }
            }
        }
    }
    
    
    // MARK: - UI Setup
    private func setupUI(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(logoutButtonPressed))
        self.navigationController?.navigationBar.isHidden = false
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(logoImageView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(usernameLabel)
        self.view.addSubview(emailLabel)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 30),
            logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            logoImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5),
            
            nameLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 16),
            nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            usernameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            emailLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
    
    
    // MARK: - Sections
    @objc private func logoutButtonPressed(){
        AuthService.shared.singOut { [weak self] error in
            if let error = error {
                print(error.localizedDescription)
            }else {
                if let sceneDelegate = self?.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.goToRootVC()
                }
            }
        }
    }
}
