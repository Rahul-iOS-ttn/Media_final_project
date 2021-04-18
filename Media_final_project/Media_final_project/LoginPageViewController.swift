//
//  ViewController.swift
//  Media_final_project
//
//  Created by TTN on 13/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class LoginPageViewController: UIViewController {
    
    
    @IBOutlet weak var SignUpPage: UIButton!
    @IBOutlet weak var SigninPage: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignInButtonNavTapped() {
        let SignInPage = storyboard?.instantiateViewController(withIdentifier: "SignInPageViewController") as! SignInPageViewController
        navigationController?.pushViewController(SignInPage, animated: true)
    }
    
    @IBAction func SignUpButtonNavTapped() {
        let SignUpPage = storyboard?.instantiateViewController(withIdentifier: "SignUpPageViewController") as! SignInPageViewController
        navigationController?.pushViewController(SignUpPage, animated: true)
    }
    
//changes
    
}

