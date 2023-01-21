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
import FacebookLogin


// MARK: Documentaion shortcut Mac(cmd + option + /), VMware(window + alt + /)

enum AuthProvider {
    case facebook(accessToken: String)
    case google(idToken: String, accessToken: String)
}

class AuthService {
    public static let shared = AuthService()
    
    // No one can create object from AuthServices
    private init(){}
    
    private func insert(user: User, completion: @escaping (Error?) -> Void){
        let db = Firestore.firestore()
        
        let data: [String: Any] = [
            "name": user.name,
            "username": user.username,
            "email": user.email,
            "profileImage": user.profileImageURLString ?? "",
        ]
        
        db.collection("users").document(user.uid).setData(data) { error in
            completion(error)
            return
        }
        
        completion(nil)
    }
    
    
    /// A method to register the user
    /// - Parameters:
    ///   - userRequest: The users information (name, email, password)
    ///   - completion: A completion with two values:
    ///     - Bool: wasRegister - Determines if the user was registered and saved in the database correctly
    ///     - Error?: An optional error from Firebase if it exists
    public func registerUser(with user: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void){
        Auth.auth().createUser(withEmail: user.email, password: user.password) { [weak self] result, error in
            guard let self = self else { return }
            
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            self.insert(user: User(uid: resultUser.uid, name: user.name, username: user.username, email: user.email, profileImageURLString: nil)) { error in
                if let error = error {
                    completion(false, error)
                    return
                }
                completion(true, error)
            }
        }
    }
    
    
    /// A method to Sign in the user with email and password
    /// - Parameters:
    ///   - userRequest: The user sign in information (email, password)
    ///   - completion: A completion called when the Firebase response with one value:
    ///     - error?: An optional error from Firebase.
    public func singIn(withUser userRequest: LoginUserRequest, completion: @escaping (Error?) -> Void){
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().signIn(withEmail: email, password: password) { _ , error in
            completion(error)
        }
    }
    
    
    /// A method that Sign In user using Social Media Providers
    /// - Parameters:
    ///   - provider: Type of signin provider
    ///   - completion: Callback function with two values:
    ///     - isSignInSuccess: A bool of state of Sign In
    ///     - error?: A optional error from Firebase
    public func signIn(withProvidere provider: AuthProvider,completion: @escaping (Bool, Error?) -> Void){
        let credential: AuthCredential!
        switch provider {
        case .facebook(let accessToken):
            credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
            
        case .google(let idToken, let accessToken):
            credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        }
        
        Auth.auth().signIn(with: credential) {[weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let user = authResult?.user else {
                completion(false, nil)
                return
            }
            
            let userInfo = User(uid: user.uid,
                            name: user.displayName ?? "",
                            username: user.displayName ?? "",
                            email: user.email ?? user.phoneNumber ?? "",
                            profileImageURLString: user.photoURL?.absoluteString ?? "")
            
            self.insert(user: userInfo) { insertError in
                if let insertError = insertError {
                    completion(false, insertError)
                    return
                }
                completion(true, nil)
            }
        }
    }
    
    
    /// A method for sign out user from Firebase and Soical Media Provider
    /// - Parameters:
    ///     - completion: A completion when it done signing out with one value:
    ///         - error?: An optional error from Firebase
    public func singOut(completion: @escaping (Error?) -> Void){
        do {
            try Auth.auth().signOut()
            
            // Facebook
            if AccessToken.isCurrentAccessTokenActive {
                LoginManager().logOut()
            }
            
            // Google
//            if GIDSignIn.sharedInstance.currentUser != nil {
            if GIDSignIn.sharedInstance.hasPreviousSignIn(){
                GIDSignIn.sharedInstance.signOut()
            }
            
            completion(nil)
            
        } catch {
            completion(error)
        }
    }
    
    /// A method to check if user is already signed in (from Firebase)
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
                      let email = snapShotData["email"] as? String
                else { return }
                
                let profileImage = snapShot["photoURL"] as? String
                
                let user = User(uid: userUID, name: name, username: username, email: email, profileImageURLString: profileImage)
                completion(.success(user))
            }
    }
}
