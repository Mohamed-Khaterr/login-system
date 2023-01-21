//
//  HomeController.swift
//  swift-login-system
//
//  Created by Khater on 1/17/23.
//

import UIKit

class HomeController: UIViewController {
    
    // MARK: - UI Components
    private let mainView = HomeView()
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signoutButtonPressed))
    }
    
    
    // MARK: - Sections
    private func fetchUserData(){
        mainView.startLoadingIndicatore()
        AuthService.shared.fetchUser { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                AlertManager.show(to: self, withTitle: "User Info", andMessage: error.localizedDescription, returnKey: "Dismiss")
                DispatchQueue.main.async {
                    self.mainView.stopLoadingIndicatore()
                }
                
            case .success(let user):
                DispatchQueue.main.async {
                    self.mainView.setNameLabel(with: user.name)
                    self.mainView.setUsernameLabel(with: user.username)
                    self.mainView.setEmailLabel(with: user.email)
                }
                
                self.downloadProfileImage(with: user.profileImageURLString ?? "")
            }
        }
    }
    
    private func downloadProfileImage(with urlString: String){
        if let url = URL(string: urlString){
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let self = self else {return}
                if let error = error {
                    AlertManager.show(to: self, withTitle: "User Info", andMessage: error.localizedDescription, returnKey: "Dismiss")
                    DispatchQueue.main.async {
                        self.mainView.stopLoadingIndicatore()
                    }
                    return
                }

                guard let data = data else {return}
                DispatchQueue.main.async {
                    self.mainView.setProfileImage(with: UIImage(data: data))
                    self.mainView.stopLoadingIndicatore()
                }
            }.resume()
            
        }else{
            DispatchQueue.main.async {
                self.mainView.stopLoadingIndicatore()
            }
        }
    }
    
    @objc private func signoutButtonPressed(){
        AuthService.shared.singOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.show(to: self, withTitle: "Sign Out", andMessage: error.localizedDescription, returnKey: "Dismiss")
            }else {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.goToRootVC()
                }
            }
        }
    }
}
