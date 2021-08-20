//
//  DetailScreenViewController.swift
//  Media_final_project
//
//  Created by TTN on 24/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import UIKit

class DetailScreenViewController: UIViewController {
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRatings: UILabel!
    @IBOutlet weak var movieLang: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    var movieDetails = MovieData()
    let constantDetail = DataModelConstants()
    var genreNameData: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

            print(movieDetails)
        movieTitle.text = movieDetails.title
        movieRatings.text = "\(String(describing: movieDetails.vote_average))"
        movieLang.text = movieDetails.original_language
        
        let urlString = "https://image.tmdb.org/t/p/w500" + movieDetails.backdrop_path!
        let url = URL(string: urlString)!
        
        backdropImage.downloadedFrom(url: url)
        // Do any additional setup after loading the view.
        
        movieDetails.genre_ids?.forEach({ (genre) in
            self.genreNameData.append(constantDetail.genreName[genre] ?? "")
        })
    }

}
