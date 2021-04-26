//
//  SignUpPageViewController.swift
//  Media_final_project
//
//  Created by TTN on 18/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit
import CoreData

class SignUpPageViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    
    @IBOutlet weak var firstNameTextfield: UITextField!
    @IBOutlet weak var lastNameTextfield: UITextField!
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var dOBTextfield: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!

    var userData = [User?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUpButtonSaveTapped () {
        
        userData = [CoreDataHandler.shared.createUserDetails(firstName: firstNameTextfield!.text ?? "", lastName: lastNameTextfield!.text ?? "", username: userNameTextfield!.text ?? "", password: passwordTextfield!.text ?? "")]
    }

}
