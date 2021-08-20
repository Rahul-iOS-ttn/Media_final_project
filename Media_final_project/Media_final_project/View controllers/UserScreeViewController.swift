//
//  UserScreeViewController.swift
//  Media_final_project
//
//  Created by TTN on 27/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit
import MobileCoreServices


class UserScreeViewController: UIViewController {
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var importButton: UIButton!
    
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
    

    @IBAction func importTapped() {
      //Create a picker specifying file type and mode
//      let documentPicker = UIDocumentPickerViewController(documentTypes: [String(kUTTypePNG)], in: .import)
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.opml"], in: UIDocumentPickerMode.import)
       documentPicker.delegate = self
       documentPicker.allowsMultipleSelection = false
       documentPicker.modalPresentationStyle = .fullScreen
       present(documentPicker, animated: true, completion: nil)
    }

}

extension UserScreeViewController: UIDocumentPickerDelegate {

    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard controller.documentPickerMode == .import, let url = urls.first else { return }
//        documentImport(image)
        controller.dismiss(animated: true)
    }

    public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true)
    }
}
