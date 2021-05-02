//
//  SignInPageViewController.swift
//  Media_final_project
//
//  Created by TTN on 18/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit
import CoreData
import FBSDKLoginKit
import GoogleSignIn

class SignInPageViewController: UIViewController, LoggableProtocol {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var facebookButton: FBLoginButton!
    
    var check: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        facebookLogin()
        googleLogin()
        if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true {
            //user is already logged in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let MainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            
            // This is to get the SceneDelegate object from your view controller
            // then call the change root view controller function to change to main tab bar
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(MainTabBarController)
        }
    }
    
    @IBAction func googleBtnTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.signIn()
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
    
    func googleLogin () {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
        
        if GIDSignIn.sharedInstance().hasPreviousSignIn() {
//            print(GIDSignIn.sharedInstance()?.currentUser)
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            print("Alredy login")
        }
    }
    
    @IBAction func signInButtonTapped(_ sender: Any) {
        
        if (Validation()) {
            let userTryingtoLogIn = CoreDataHandler.shared.fetchUserDetails(withUserName: userNameTextField!.text ?? "") // if nil found give an alert for user not found - error Handling implement
            
            if userTryingtoLogIn?.password == passwordTextField!.text {
                UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let MainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                
                // This is to get the SceneDelegate object from your view controller
                // then call the change root view controller function to change to main tab bar
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(MainTabBarController)
                
            } else {
                openAlert(title: "Alert", message: "Validation Falied", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }
        } else {
            openAlert(title: "Alert", message: "Please add detail.", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                print("Okay clicked!")
            }])
        }
    }
}

// MARK: - Facebook and Google Login Extension
extension SignInPageViewController: LoginButtonDelegate {
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

extension SignInPageViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        print("\(user.profile.email ?? "No email" )")
    }
}

// MARK: - Validation Extention

extension SignInPageViewController{
    fileprivate func Validation()-> Bool {
        if let username = userNameTextField.text, let password = passwordTextField.text{
            if (username == "" || !(self.validateUserName(username: username))){
                openAlert(title: "Alert", message: "Please Check your email address", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }else if (!(self.verifyPassword(password: password)) || password == ""){
                openAlert(title: "Alert", message: "Please enter valid password", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
                    print("Okay clicked!")
                }])
            }else{
                // Navigation - Home Screen
                check = true
            }
        }else{
            check = false
        }
        return check
    }
}
