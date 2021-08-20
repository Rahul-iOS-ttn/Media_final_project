//
//  DetailScreenThemedViewController.swift
//  Media_final_project
//
//  Created by TTN on 06/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class DetailScreenThemedViewController: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var langLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movieDetails = MovieData()
    let constantDetail = DataModelConstants()
    var genreNameData: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        let urlString = "https://image.tmdb.org/t/p/w500" + movieDetails.backdrop_path!
        let url = URL(string: urlString)!
        
        contentView.layer.cornerRadius = 40
        
        backdropImageView.downloadedFrom(url: url)
        
        titleLabel.text = movieDetails.title
        
        langLabel.text = movieDetails.original_language
        voteLabel.text = "\(movieDetails.vote_average ?? 0)"
        overviewLabel.text = movieDetails.overview
        
        movieDetails.genre_ids?.forEach({ (genre) in
            self.genreNameData.append(constantDetail.genreName[genre] ?? "")
        })
        genreLabel.text = genreNameData.joined(separator: ", ")
    }
}
