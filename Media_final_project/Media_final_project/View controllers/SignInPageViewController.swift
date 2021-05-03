//
//  SignInPageViewController.swift
//  Media_final_project
//
//  Created by TTN on 18/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit
import CoreData

class SignInPageViewController: UIViewController, LoggableProtocol {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var check: Bool = false
    
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
        
        if (Validation()) {
            let userTryingtoLogIn = CoreDataHandler.shared.fetchUserDetails(withEmail: emailTextField!.text ?? "") // if nil found give an alert for user not found - error Handling implement
            
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

// MARK: - Validation Extention

extension SignInPageViewController{
    fileprivate func Validation()-> Bool {
        if let email = emailTextField.text, let password = passwordTextField.text{
            if (email == "" || !(self.verifyEmail(email: email))){
                openAlert(title: "Alert", message: "Please Check your email", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{ _ in
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
