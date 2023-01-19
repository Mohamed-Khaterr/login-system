//
//  AuthService.swift
//  swift-login-system
//
//  Created by Khater on 1/18/23.
//

import FirebaseAuth
import FirebaseFirestore
import FirebaseCore
import GoogleSignIn


// MARK: - Documentaion shortcut Mac(cmd + option + /), VMware(window + alt + /)

class AuthService {
    public static let shared = AuthService()
    
    // No one can create object from AuthServices
    private init(){}
    
    
    /// A method to register the user
    /// - Parameters:
    ///   - userRequest: The users information (name, email, password)
    ///   - completion: A completion with two values:
    ///     - Bool: wasRegister - Determines if the user was registered and saved in the database correctly
    ///     - Error?: An optional error from Firebase if it exists
    public func registerUser(with userRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void){
        let name = userRequest.name
        let username = userRequest.username
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            let db = Firestore.firestore()
            
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "name": name,
                    "username": username,
                    "email": email,
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    
                    completion(true, nil)
                }
        }
    }
    
    public func singIn(with userRequest: LoginUserRequest, completion: @escaping (Error?) -> Void){
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().signIn(withEmail: email, password: password) { _ , error in
            completion(error)
        }
    }
    
    public func otheProviderSignIn(credential: AuthCredential, completion: @escaping (Bool, Error?) -> Void){
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard
                let user = authResult?.user
            else { return }
            
            let db = Firestore.firestore()
            
            db.collection("users")
                .document(user.uid)
                .setData([
                    "name": user.displayName ?? "No name found!",
                    "username": user.displayName ?? "No username found!",
                    "email": user.email ?? user.phoneNumber ?? "No email found!",
                    "photoURL": user.photoURL?.absoluteString ?? "nil"
                    
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    
                    completion(true, nil)
                }
        }
    }
    
    
    public func singOut(completion: @escaping (Error?) -> Void){
        do {
            try Auth.auth().signOut()
            completion(nil)
            
        } catch {
            completion(error)
        }
    }
    
    public func isUserSignedIn() -> Bool{
        return Auth.auth().currentUser != nil
    }
    
    
    public func forgotPassword(withEmail email: String, completion: @escaping (Error?) -> Void){
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
    
    public func fetchUser(completion: @escaping (Result<User, Error>) -> Void){
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userUID)
            .getDocument { snapShot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let snapShot = snapShot,
                      let snapShotData = snapShot.data(),
                      let name = snapShotData["name"] as? String,
                      let username = snapShotData["username"] as? String,
                      let email = snapShotData["email"] as? String,
                      let profileImage = snapShot["photoURL"] as? String
                else { return }
                
                let user = User(uid: userUID, name: name, username: username, email: email, profileImageURLString: profileImage)
                completion(.success(user))
            }
    }
}
