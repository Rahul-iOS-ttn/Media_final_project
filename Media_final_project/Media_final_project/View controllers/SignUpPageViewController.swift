//
//  SignUpPageViewController.swift
//  Media_final_project
//
//  Created by TTN on 18/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit
import CoreData
import FBSDKLoginKit
import GoogleSignIn

class SignUpPageViewController: UIViewController, LoggableProtocol {
    
    var managedObjectContext: NSManagedObjectContext!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    
    
    
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var dobPicker: UIDatePicker!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var facebookButton: FBLoginButton!
    
    var userData = [User?]()
    
    var check: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dobPicker.datePickerMode = .date
        dobPicker.preferredDatePickerStyle = .wheels
        facebookLogin()
        
    }
    
    func facebookLogin() {
        if let token = AccessToken.current,
            !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name,name, middle_name, name_format, age_range"], tokenString: token, version: nil, httpMethod: .get)
            request.start { (connection, result, error) in
                print("\(String(describing: result))")
            }
        } else {
            facebookButton.permissions = ["public_profile", "email"]
            facebookButton.delegate = self
        }
    }
    
    @IBAction func GoogleLogin(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    func googleLogin () {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        if GIDSignIn.sharedInstance().hasPreviousSignIn() {
            //            print(GIDSignIn.sharedInstance()?.currentUser)
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            print("Alredy login")
        }
    }
    @IBAction func SignUpButtonSaveTapped () {
        
        if(validation()){
            userData = [CoreDataHandler.shared.createUserDetails(firstName: firstNameTextfield!.text ?? "", lastName: lastNameTextfield!.text ?? "", username: userNameTextfield!.text ?? "", password: passwordTextfield!.text ?? "", email: emailTextField!.text ?? "", dob: dobPicker.date)]
            
            debugPrint(userData)
            
            let SignInPage = storyboard?.instantiateViewController(withIdentifier: "SignInPageViewController") as! SignInPageViewController
            navigationController?.pushViewController(SignInPage, animated: true)
        } else {
            openAlert(title: "Alert", message: "Please Check your details", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
            print("Please Check your details")
        }
    }
    
}

// MARK: - Facebook and Google Login Extension

extension SignUpPageViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name,name, middle_name, name_format, age_range"], tokenString: token, version: nil, httpMethod: .get)
        request.start { (connection, result, error) in
            print("\(String(describing: result))")
        }
        UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let MainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(MainTabBarController)// this in sign in page
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logout")
    }
}

extension SignUpPageViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("\(user.profile.email ?? "No email" )")
    }
}
// MARK: - validation extension

extension SignUpPageViewController {
    
    fileprivate func validation() -> Bool {
        
        if let username = userNameTextfield.text, let password = passwordTextfield.text, let firstName = firstNameTextfield.text, let lastName = lastNameTextfield.text, let email = emailTextField.text{
            if firstName == "" {
                openAlert(title: "Alert", message: "Please enter your First Name", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                print("Please enter your First Name")
            } else if lastName == "" {
                openAlert(title: "Alert", message: "Please enter your Last Name", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                print("Please enter your Last Name")
            } else if (!(self.verifyEmail(email: email)) || email == "") {
                openAlert(title: "Alert", message: "Please check your email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                print("Check your email")
            } else if (username == "" || !(self.validateUserName(username: username))) {
                openAlert(title: "Alert", message: "Please enter your username", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                print("Please enter your username")
            } else if (!(self.verifyPassword(password: password)) || password == "") {
                openAlert(title: "Alert", message: "Please check your password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
                print("Please enter your password")
            } else {
                
                check = true
                userData = [CoreDataHandler.shared.createUserDetails(firstName: firstNameTextfield!.text ?? "", lastName: lastNameTextfield!.text ?? "", username: userNameTextfield!.text ?? "", password: passwordTextfield!.text ?? "", email: emailTextField!.text ?? "", dob: dobPicker.date)]
                
                debugPrint(userData)
                
                let SignInPage = storyboard?.instantiateViewController(withIdentifier: "SignInPageViewController") as! SignInPageViewController
                navigationController?.pushViewController(SignInPage, animated: true)
            }
        }else {
            check = false
            openAlert(title: "Alert", message: "Please Check your details", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
            print("Please Check your details")
        }
        return check
    }
}
