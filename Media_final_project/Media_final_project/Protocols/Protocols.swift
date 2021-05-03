//
//  Protocols.swift
//  Media_final_project
//
//  Created by TTN on 02/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation
import UIKit


protocol LoggableProtocol { }

//MARK: - Theme Protocol

protocol ThemeProtocol {
    var mainFontName : UIFont { get }
    var textColor: UIColor { get }
    var accent: UIColor { get }
    var background: UIColor { get }
    var tint: UIColor { get }
}
