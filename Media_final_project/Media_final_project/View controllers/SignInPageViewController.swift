//
//  SignInPageViewController.swift
//  Media_final_project
//
//  Created by TTN on 18/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit
import CoreData

class SignInPageViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if UserDefaults.standard.bool(forKey: "ISUSERLOGGEDIN") == true {
            //user is already logged in
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let MainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            
            // This is to get the SceneDelegate object from your view controller
            // then call the change root view controller function to change to main tab bar
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(MainTabBarController)
        }
    }
    @IBAction func signInButtonTapped(_ sender: Any) {
        
        let userTryingtoLogIn = CoreDataHandler.shared.fetchUserDetails(withUserName: userNameTextField!.text ?? "") // if nil found give an alert for user not found - error Handling implement
        
        if userTryingtoLogIn?.password == passwordTextField!.text {
            UserDefaults.standard.set(true, forKey: "ISUSERLOGGEDIN")
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let MainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            
            // This is to get the SceneDelegate object from your view controller
            // then call the change root view controller function to change to main tab bar
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(MainTabBarController)
            
        } else {
            print("error here")
        }
        
    }
}
