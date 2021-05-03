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
    @IBOutlet weak var themeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
    
    }
    
    @IBAction func themeSwitchChanged(_ sender: UISwitch) {
        Theme.current = sender.isOn ? LightTheme() : DarkTheme()
        UserDefaults.standard.set(sender.isOn, forKey: "Theme")
        applyTheme()
    }
    
    
    fileprivate func applyTheme() {
        view.backgroundColor = Theme.current.background
        themeLabel.textColor = Theme.current.textColor
        themeLabel.font = Theme.current.mainFontName
        themeLabel.backgroundColor = Theme.current.accent
    }
    
    @IBAction func logoutButtonTapped () {
        
        UserDefaults.standard.set(false, forKey: "ISUSERLOGGEDIN")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginPageViewController = storyboard.instantiateViewController(identifier: "LoginPageViewController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginPageViewController)
    }

}
