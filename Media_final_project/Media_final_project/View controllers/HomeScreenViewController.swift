//
//  HomeScreenViewController.swift
//  Media_final_project
//
//  Created by TTN on 21/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit


class HomeScreenViewController: UIViewController {
    @IBOutlet weak var mainScreenTableView: UITableView!
    
    var homeScreenViewModel = HomeScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScreenTableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        mainScreenTableView.delegate = self
        mainScreenTableView.dataSource = self
        getHomeScreenData()
        self.mainScreenTableView.reloadData()
    }
    
    func getHomeScreenData() {
        homeScreenViewModel.getInformation { (dataFetchSuccess, error) in
            if dataFetchSuccess {
                self.mainScreenTableView.reloadData()
            } else {
                print(error)
            }
        }
    }
}

extension HomeScreenViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeScreenViewModel.genreItems.count
        //        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainScreenTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        if homeScreenViewModel.genreItems.count > 0
        {cell.configure(with: homeScreenViewModel.genreItems[indexPath.row].genreMovies, genreName: homeScreenViewModel.genreItems[indexPath.row].genre)// manual index of genre that you will make
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
