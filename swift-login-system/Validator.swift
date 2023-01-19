//
//  Validator.swift
//  swift-login-system
//
//  Created by Khater on 1/19/23.
//

import Foundation

class Validator {
    private init() {}
    
    static func isValidEmail(for email: String) -> Bool{
        // TODO: - Need Real Validation email not this shit
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)// remove all white space and new lines (\n) from given string
        let emailRegEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegEX)
        return emailPredicate.evaluate(with: email)
    }
    
    static func isValidUsername(for username: String) -> Bool {
        // TODO: - Need Real Validation for username not this shit
        let username = username.trimmingCharacters(in: .whitespacesAndNewlines)// remove all white space and new lines (\n) from given string
        let usernameRegEX = "\\w{7,18}"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES %@", usernameRegEX)
        return usernamePredicate.evaluate(with: username)
    }
    
    static func isPasswordValid(for password: String) -> Bool {
        // TODO: - Need Real Validation for passwrod not this shit
        let passwordRegEX = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,32}$" // Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegEX)
        return passwordPredicate.evaluate(with: password)
        
    }
}
