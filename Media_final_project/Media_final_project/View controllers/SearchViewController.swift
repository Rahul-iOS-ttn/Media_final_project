//
//  SearchViewController.swift
//  Media_final_project
//
//  Created by TTN on 03/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    var allDataforSearch = [movieData]()
    var filteredData = [movieData]()
    var homevm = HomeScreenViewModel()
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTableView.register(SearchTableViewCell.nib(), forCellReuseIdentifier: SearchTableViewCell.identifier)
        searchTableView.delegate = self
        searchTableView.dataSource = self
        allDataAppend()
        // Do any additional setup after loading the view.
    }

    func allDataAppend () {
        for genre in homevm.genreItems {
            allDataforSearch.append(contentsOf: genre.genreMovies)
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isSearching {
            return filteredData.count
        } else {
         return allDataforSearch.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        if isSearching {
            cell.configure(with: filteredData[indexPath.row])
        } else {
         cell.configure(with: allDataforSearch[indexPath.row])
        }
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = allDataforSearch.filter({$0.title!.lowercased().prefix(searchText.count) == searchText.lowercased()})
        isSearching = true
        searchTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.text = ""
        searchTableView.reloadData()
    }
}
