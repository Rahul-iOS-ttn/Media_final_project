//
//  UserScreeViewController.swift
//  Media_final_project
//
//  Created by TTN on 27/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class UserScreeViewController: UIViewController {
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    
    @IBAction func logoutButtonTapped () {
        
        UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginPageViewController = storyboard.instantiateViewController(identifier: "LoginPageViewController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginPageViewController)
    }

}
