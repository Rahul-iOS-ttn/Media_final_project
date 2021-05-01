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

class SignUpPageViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var dOBTextfield: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var facebookButton: FBLoginButton!

    var userData = [User?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let token = AccessToken.current,
            !token.isExpired {
            // User is logged in, do work such as go to next view controller.
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name,name, middle_name, name_format, age_range"], tokenString: token, version: nil, httpMethod: .get)
            request.start { (connection, result, error) in
                print("\(String(describing: result))")
            }
            UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let MainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(MainTabBarController)
        } else {
            facebookButton.permissions = ["public_profile", "email"]
            facebookButton.delegate = self
        }
    }
    
    @IBAction func SignUpButtonSaveTapped () {
        
        userData = [CoreDataHandler.shared.createUserDetails(firstName: firstNameTextfield!.text ?? "", lastName: lastNameTextfield!.text ?? "", username: userNameTextfield!.text ?? "", password: passwordTextfield!.text ?? "")]
        
        debugPrint(userData)
        
        let SignInPage = storyboard?.instantiateViewController(withIdentifier: "SignInPageViewController") as! SignInPageViewController
        navigationController?.pushViewController(SignInPage, animated: true)
    }

}

extension SignUpPageViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name,name, middle_name, name_format, age_range"], tokenString: token, version: nil, httpMethod: .get)
        request.start { (connection, result, error) in
            print("\(String(describing: result))")
            
        }
    }
    
    
    
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("logout")
    }
    
    
}
