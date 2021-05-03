//
//  HomeScreenViewController.swift
//  Media_final_project
//
//  Created by TTN on 21/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit
import SideMenu


class HomeScreenViewController: UIViewController {
    
    
    @IBOutlet weak var mainScreenTableView: UITableView!
    
    var homeScreenViewModel = HomeScreenViewModel()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(getHomeScreenData), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    private var sideMenu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScreenTableView.addSubview(self.refreshControl)
        mainScreenTableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        mainScreenTableView.register(BannerTableViewCell.nib(), forCellReuseIdentifier: BannerTableViewCell.identifier)
        mainScreenTableView.estimatedRowHeight = UITableView.automaticDimension
        mainScreenTableView.rowHeight = UITableView.automaticDimension
        mainScreenTableView.delegate = self
        mainScreenTableView.dataSource = self
        getHomeScreenData()
        
        let menu = MenuController(with: SideMenuItem.allCases)
        
        menu.delegate = self
        
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        sideMenu?.setNavigationBarHidden(true, animated: false)
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
    }
    
    @objc func getHomeScreenData() {
        homeScreenViewModel.getInformation { (dataFetchSuccess, error) in
            if dataFetchSuccess {
                self.mainScreenTableView.reloadData()
            } else {
                print(error)
            }
        }
    }
    @IBAction func didTapMenuButton(){
        present(sideMenu!, animated: true)
    }
}
// MARK: - TableView and Side Drawer
extension HomeScreenViewController: UITableViewDataSource, UITableViewDelegate, MenuControllerDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeScreenViewModel.genreItems.count
        //        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = mainScreenTableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.identifier, for: indexPath) as! BannerTableViewCell
            cell.configure(homeScreenViewModel.genreItems[indexPath.row])
            return cell
        } else {
            let cell = mainScreenTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
            cell.configure(with: homeScreenViewModel.genreItems[indexPath.row].genreMovies, genreName: homeScreenViewModel.genreItems[indexPath.row].genre)// manual index of genre that you will make
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func didSelectMenuItem(menuOption: SideMenuItem) {
        sideMenu?.dismiss(animated: true, completion: nil)
        
        
        switch menuOption {
        case .home:
            openAlert(title: "Alert", message: "Home Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .location:
            openAlert(title: "Alert", message: "Location Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .movies:
            openAlert(title: "Alert", message: "Movies Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .notification:
            openAlert(title: "Alert", message: "Notification Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .employee:
            openAlert(title: "Alert", message: "Employee Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .country:
            openAlert(title: "Alert", message: "Country Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .language:
            openAlert(title: "Alert", message: "Language Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .aboutus:
            openAlert(title: "Alert", message: "About us Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .faq:
            openAlert(title: "Alert", message: "FAQ Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .changetheme:
            openAlert(title: "Alert", message: "Theme Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        case .logout:
            openAlert(title: "Alert", message: "Logout Tapped", alertStyle: .alert, actionTitles: ["Okay"], actionStyles: [.default], actions: [{_ in }])
        }
        
    }
}
