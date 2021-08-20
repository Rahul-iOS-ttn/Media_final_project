//
//  TableViewCell.swift
//  Media_final_project
//
//  Created by TTN on 21/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var genreLabel: UILabel!
    
    weak var delegate: TableViewCellProtocol?
    var cellIndex: Int = 0
    static let identifier = "TableViewCell"
    
    lazy var information = [MovieData]()
    
    static func nib() -> UINib {
        return UINib(nibName: "TableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        genreCollectionView.register(MainCollectionViewCell.nib(), forCellWithReuseIdentifier: MainCollectionViewCell.identifier )
        
        genreCollectionView.delegate = self
        genreCollectionView.dataSource = self
        
        
    }
    
    override func prepareForReuse() {
        information.removeAll()
    }
    
}

extension TableViewCell : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return information.count
    }
    
    func configure(with information : [MovieData],genreName: String){ //change this finction to take an array of strings which displays genres
        self.information = information
        genreLabel.text = genreName
        genreCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = genreCollectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        cell.configure(with: information[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cellTapped(sectionIndex: cellIndex, cellIndex: indexPath.row)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
