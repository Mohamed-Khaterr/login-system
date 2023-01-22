//
//  RegisterController.swift
//  swift-login-system
//
//  Created by Khater on 1/17/23.
//

import UIKit

class RegisterController: UIViewController, UINavigationControllerDelegate {
    
    // MARK: - UI Components
    private lazy var mainView = RegisterView(delegate: self)
    
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
}


// MARK: - RegisterView Delegate
extension RegisterController: RegisterViewDelegate{
    func pickImageButtonPressed() {
        let alert = UIAlertController(title: "Choose Profile Image", message: nil, preferredStyle: .actionSheet)
        let cameraButton = UIAlertAction(title: "Camera", style: .default) { _ in
            self.showImagePikcer(source: .camera)
        }
        
        let libraryButton = UIAlertAction(title: "Library", style: .default) { _ in
            self.showImagePikcer(source: .photoLibrary)
        }
        
        let cancle = UIAlertAction(title: "Cancle", style: .cancel, handler: nil)
        
        alert.addAction(cameraButton)
        alert.addAction(libraryButton)
        alert.addAction(cancle)
        present(alert, animated: true, completion: nil)
    }
    
    private func showImagePikcer(source: UIImagePickerController.SourceType){
        print("Source rawValue", source.rawValue)
        guard UIImagePickerController.isSourceTypeAvailable(source) else {
            print("Source not Available")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    func signUpButtonPressed() {
        let name = mainView.name
        let username = mainView.username
        let email = mainView.email
        let password = mainView.password
        
        if name.isEmpty || username.isEmpty || email.isEmpty || password.isEmpty {
            AlertManager.show(to: self, withTitle: "Sign Up", andMessage: "Please fill all fields,\nand Try Again.")
            return
        }

        // Username Check
        if !Validator.isValidUsername(for: username){
            AlertManager.show(to: self, withTitle: "Invalid Username", andMessage: "Username is not valid,\nTry Again.")
            return
        }

        // Email Check
        if !Validator.isValidEmail(for: email){
            AlertManager.show(to: self, withTitle: "Invalid Email", andMessage: "Email is not valid,\nTry Again.")
            return
        }

        // Password Check
        if !Validator.isPasswordValid(for: password) {
            AlertManager.show(to: self,
                              withTitle: "Invalid Password",
                              andMessage: "Password is not valid.\nMake sure that the password contains:\nMinimum 8 characters at least.\n1 Alphabet.\n1 Number.\n1 Special Character.")
            return
        }

        mainView.enabaleViews(false)
        let registerUser = RegisterUserRequest(name: name, username: username.lowercased(), email: email.lowercased(), password: password)

        AuthService.shared.registerUser(with: registerUser) { [weak self] isSignUpSuccess, error in
            guard let self = self else { return }
            self.mainView.enabaleViews(true)

            if let error = error {
                AlertManager.show(to: self, withTitle: "Server Error!", andMessage: error.localizedDescription)
                return
            }

            if isSignUpSuccess {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.goToRootVC()
                }
            }else{
                fatalError("False: register the user")
            }
        }
    }
    
    func termsTextViewPressed(urlString: String) -> Bool {
        let webVC = WebViewController(with: URL(string: urlString)!)
        let nav = UINavigationController(rootViewController: webVC)
        present(nav, animated: true, completion: nil)
        return false
    }
    
    func signInButtonPressed() {
        navigationController?.popToRootViewController(animated: true)
    }
}


// MARK: - UIImagePicker Delegate
extension RegisterController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let selectedImage = info[.originalImage] as? UIImage {
            mainView.profileImage = selectedImage
        }
    }
}
