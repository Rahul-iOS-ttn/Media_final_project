//
//  ThemeSet.swift
//  Media_final_project
//
//  Created by TTN on 03/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

//MARK: - Light Theme

class LightTheme: ThemeProtocol{
    
    var textColor: UIColor = UIColor.black
    var mainFontName: UIFont = UIFont(name: "Noteworthy", size: 20)!
    var accent: UIColor =  UIColor(named: "accent")!
    var background: UIColor =  UIColor(named: "background")!
    var tint: UIColor = UIColor(named: "tint")!
}


//MARK: - Dark Theme

class DarkTheme: ThemeProtocol {
    
    var textColor: UIColor = UIColor.white
    var mainFontName: UIFont = UIFont(name: "zapfino", size: 20)!
    var accent: UIColor =  UIColor(named: "background")!
    var background: UIColor =  UIColor(named: "tint")!
    var tint: UIColor = UIColor(named: "accent")!
}
