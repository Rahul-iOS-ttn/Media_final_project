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
    
    static let identifier = "MainCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MainCollectionViewCell", bundle: nil)
    }
    public func configure(with information : MovieData){
        
        let imageHomeURL = "https://image.tmdb.org/t/p/w500"
        
        if let posterpath = information.poster_path ?? information.backdrop_path, let url = URL(string: imageHomeURL + posterpath){
            poster.contentMode = .scaleAspectFit
            poster.downloadedFrom(url: url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        poster.layer.cornerRadius = 10
        poster.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        poster.image = nil
    }
    
}
