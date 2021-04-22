//
//  Backend_functions.swift
//  Media_final_project
//
//  Created by TTN on 22/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation
import UIKit


//"adult":false,
//"backdrop_path":"/1uKHoFWyYJn060dpIXUCU7Wbc15.jpg", detail screen image will be used with the integrations of stcking and stack view
//"genre_ids":[
//   10752,
//   18,
//   28
//],
//"id":228150,
//"original_language":"en",
//"original_title":"Fury",
//"overview":"In the last months of World War II, as the Allies make their final push in the European theatre, a battle-hardened U.S. Army sergeant named 'Wardaddy' commands a Sherman tank called 'Fury' and its five-man crew on a deadly mission behind enemy lines. Outnumbered and outgunned, Wardaddy and his men face overwhelming odds in their heroic attempts to strike at the heart of Nazi Germany.",
//"popularity":71.549,
//"poster_path":"/pfte7wdMobMF4CVHuOxyu6oqeeA.jpg",
//"release_date":"2014-10-15",
//"title":"Fury",
//"video":false,
//"vote_average":7.5,
//"vote_count":8984

struct movieData : Decodable {
    var adult: Bool
    var backdrop_path: String
    var genre_ids: [Int]
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Double
    var poster_path: String
    var release_date: String
    var title: String
    var video: Bool
    var vote_average: Double
    var vote_count: Int
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

class API_integrations {
    let imageHomeURL = "https://image.tmdb.org/t/p/w500"
    
    lazy var information = [movieData]()
    
    func downloadJSON(completed: @escaping () -> ()) {
        
        
        let homeURL: String = "https://api.themoviedb.org/3/"
        
        let popular: String = "discover/movie?sort_by=popularity.desc"
        //paths to specific links will be defines with their respective use-cases
        
        let api_key: String = "&api_key=820016b7116f872f5f27bf56f9fdfb66"
        
        let finalURL = URL(string: homeURL + popular + api_key)
        //    let finalURL = homeURL + popular + api_key
        
        
        
        URLSession.shared.dataTask(with: finalURL!) { (data, response, error) in
            
            if error == nil {
                do {
                    self.information = try JSONDecoder().decode([movieData].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                    
                }catch {
                    print("JSON NOT FOUND")
                }
            }
        }.resume()
    }
}