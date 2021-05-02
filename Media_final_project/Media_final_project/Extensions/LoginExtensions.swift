//
//  LoginExtensions.swift
//  Media_final_project
//
//  Created by TTN on 02/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation
import UIKit


extension LoggableProtocol where Self: UIViewController {
    func verifyEmail(email: String) -> Bool {
        let emailVerificationRegex: String = "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$"
        let validCheck = NSPredicate(format:"SELF MATCHES %@", emailVerificationRegex)
        return validCheck.evaluate(with: email)
    }
    func verifyPassword(password: String) -> Bool {
        let passwordVerificationRegex: String = "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$"
        //        ^                         Start anchor
        //        (?=.*[A-Z].*[A-Z])        Ensure string has two uppercase letters.
        //        (?=.*[!@#$&*])            Ensure string has one special case letter.
        //        (?=.*[0-9].*[0-9])        Ensure string has two digits.
        //        (?=.*[a-z].*[a-z].*[a-z]) Ensure string has three lowercase letters.
        //        .{8}                      Ensure string is of length 8.
        //        $                         End anchor. password - AB@12cde
        
        let validCheck = NSPredicate(format:"SELF MATCHES %@", passwordVerificationRegex)
        
        return validCheck.evaluate(with: password)
    }
    func validateUserName(username: String) -> Bool{
        let usernameVerificationRegex: String = "^(?=.{8,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$"
        
        let validCheck = NSPredicate(format:"SELF MATCHES %@", usernameVerificationRegex)
        
        return validCheck.evaluate(with: username)
        
        //rules for username regex
//        Only contains alphanumeric characters, underscore and dot.
//        Underscore and dot can't be at the end or start of a username (e.g _username / username_ / .username / username.).
//        Underscore and dot can't be next to each other (e.g user_.name).
//        Underscore or dot can't be used multiple times in a row (e.g user__name / user..name).
//        Number of characters must be between 8 to 20.

    }
}
