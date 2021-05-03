//
//  MainCollectionViewCell.swift
//  Media_final_project
//
//  Created by TTN on 21/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var poster: UIImageView!
    
    //    let id : String = "\(myObject.id)"
    //    let urlString = "https://picsum.photos/200/300?image=" + id
    //
    //    let url = URL(string: urlString)!
    //    myImageView.contentMode = .scaleAspectFill
    //    myImageView.downloadedFrom(url: url)
    
    
    static let identifier = "MainCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MainCollectionViewCell", bundle: nil)
    }
    public func configure(with information : movieData){
        
        let imageHomeURL = "https://image.tmdb.org/t/p/w500"
        let urlString = imageHomeURL + (information.poster_path ?? "")
        let url = URL(string: urlString)!
        
        poster.contentMode = .scaleAspectFit
        poster.downloadedFrom(url: url)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        poster.layer.cornerRadius = 10
        poster.clipsToBounds = true
    }
    
}
