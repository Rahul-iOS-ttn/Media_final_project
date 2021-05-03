//
//  SearchTableViewCell.swift
//  Media_final_project
//
//  Created by TTN on 03/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    static let identifier = "SearchTableViewCell"
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    
    
    static func nib() -> UINib {
        return UINib(nibName: "SearchTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with movie : MovieData){ //change this finction to take an array of strings which displays genres
        movieTitle.text = movie.title
        
        let urlString = "https://image.tmdb.org/t/p/w500" + movie.poster_path!
        let url = URL(string: urlString)!
        moviePoster.contentMode = .scaleAspectFill
        moviePoster.downloadedFrom(url: url)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
