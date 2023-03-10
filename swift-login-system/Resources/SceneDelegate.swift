//
//  SceneDelegate.swift
//  swift-login-system
//
//  Created by Khater on 1/17/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        setupWindow(withScene: scene)
        goToRootVC()
    }
    
    private func setupWindow(withScene scene: UIScene){
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    public func goToRootVC(){
        let rootVC: UIViewController!
        if AuthService.shared.isUserSignedIn() {
            rootVC = HomeController()
        }else{
            rootVC = LoginController()
        }
        
        let nav = UINavigationController(rootViewController: rootVC)
        nav.modalPresentationStyle = .fullScreen
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.window?.layer.opacity = 0
                
            } completion: { [weak self] done in
                
                self?.window?.rootViewController = nav
                
                UIView.animate(withDuration: 0.25) { [weak self] in
                    self?.window?.layer.opacity = 1
                }
            }

        }
    }
}

