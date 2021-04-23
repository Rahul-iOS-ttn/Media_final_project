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
    
    var api = API_integrations()
    var information = [movieData](){
        didSet{mainScreenTableView.reloadData()}
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScreenTableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        mainScreenTableView.delegate = self
        mainScreenTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        information = api.downloadJSON {}//here is nothing
        debugPrint(api.information[0])
        debugPrint(information[0])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return information.count //here return the number of cells you are making 1-popular, 2-best dramas, 3 - kids movies, 4-best dramas, 5 - best rated movies rated R
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainScreenTableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.configure(with: information, pos: indexPath.row)// manual index of genre that you will make
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
}
