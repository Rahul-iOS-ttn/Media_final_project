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


    override func viewDidLoad() {
        super.viewDidLoad()

        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//        loadData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUpButtonSaveTapped () {
        let userItem = User(context: managedObjectContext)
        
        userItem.firstname = firstNameTextfield!.text
        userItem.lastname = lastNameTextfield!.text
        userItem.username = userNameTextfield!.text
        userItem.password = passwordTextfield!.text
        //add DOB part when Date Picker is available
        
        do {
            try self .managedObjectContext.save()
//            self.loadData()
        }catch {
            print("Could not save data \(error.localizedDescription)")
        }
    }

}
