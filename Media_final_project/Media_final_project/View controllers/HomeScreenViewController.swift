//
//  HomeScreenViewController.swift
//  Media_final_project
//
//  Created by TTN on 21/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class Component: UIImageView {
    
    let label = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        //update constraints for them to converge on bottom left corner
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func configure(text: String) {
        label.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




class HomeScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var mainScreenTableView: UITableView!
    
    let genre: [String] = ["Popular","Best Dramas","Kids Movies", "Best Movies"]
    
    var api = API_integrations()
    //    var information = [movieData](){
    //        didSet{mainScreenTableView.reloadData()}
    //    }
    var information = [[movieData]]()
    var instance = [movieData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScreenTableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        mainScreenTableView.delegate = self
        mainScreenTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        //        information =
        //        api.downloadJSON { information in
        //            self.information = information
        //            self.mainScreenTableView.reloadData()
        //        }
        self.getInformation(for: genre)
    }
    
    
    func getInformation(for genres: [String]) {
        
        let api = API_integrations()
        
        for genre in genres {
            api.DownloadCase(for: genre){ information in
                self.instance = information
                self.information.append(self.instance)
                self.mainScreenTableView.reloadData()
            }
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genre.count
        //        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainScreenTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        if information.count > 0
        {cell.configure(with: information[indexPath.row], genreName: genre[indexPath.row])// manual index of genre that you will make
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
