//
//  ViewController.swift
//  Media_final_project
//
//  Created by TTN on 13/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    
    @IBOutlet weak var signUpPage: UIButton!
    @IBOutlet weak var signinPage: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButtonNavTapped(_ sender: Any) {
        let signInPage = storyboard?.instantiateViewController(withIdentifier: "SignInPageViewController") as! SignInPageViewController
        navigationController?.pushViewController(signInPage, animated: true)
    }
    
    @IBAction func signUpButtonNavTapped(_ sender: Any) {
        let signUpPage = storyboard?.instantiateViewController(withIdentifier: "SignUpPageViewController") as! SignUpPageViewController
        navigationController?.pushViewController(signUpPage, animated: true)
    }
    
//changes
    
}

