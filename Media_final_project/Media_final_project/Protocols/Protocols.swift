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

//MARK: - Collection and Table Delegate protocol

/// Description - This method is used as for getting the cell index number and section number from the table view and then that data can be used for other tasks like initializing of a view controller using the data of cell
protocol TableViewCellProtocol: AnyObject where Self: UITableViewDelegate {
    func cellTapped(sectionIndex: Int, cellIndex: Int)
}

protocol BannerViewCellProtocol: AnyObject where Self: UITableViewDelegate {
    func itemTapped(sectionIndex: Int, itemIndex: Int)
}
