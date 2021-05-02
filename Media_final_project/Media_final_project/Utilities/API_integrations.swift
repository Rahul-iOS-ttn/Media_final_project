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

class API_integrations {
    let imageHomeURL = "https://image.tmdb.org/t/p/w500"
    
    var completeInformation: MainData?
    
    let session = URLSession.shared
    
    func downloadJSON(finalURL: URL?, completed: @escaping (Result<[movieData], Error>) -> Void) {
        
        _ = session.dataTask(with: finalURL!) { (data, response, error) in
            if let dataError = error {
                DispatchQueue.main.async {
                    completed(.failure(dataError))
                }
            } else if let information = data {
                do {
                    self.completeInformation = try JSONDecoder().decode(MainData.self, from: information)
                    DispatchQueue.main.async {//result data type use and return error if it happens here
                        completed(.success(self.completeInformation!.results!))
                    }
                }catch {
                    DispatchQueue.main.async {
                        completed(.failure(NSError(domain: "Error in data parsing my friend", code: 101, userInfo: nil)))
                    }
                }
            }else {
                DispatchQueue.main.async {
                    completed(.failure(NSError(domain: "Error api download", code: 101, userInfo: nil)))
                }
            }
        }.resume()
    }
    
    func DownloadCase(for genreCategory: String, downloadCaseCompleted: @escaping (Result<[movieData], Error>) -> Void) {
        let homeURL: String = "https://api.themoviedb.org/3/"
        let api_key: String = "&api_key=820016b7116f872f5f27bf56f9fdfb66"
        switch genreCategory { // If a category fails to retrieve data then have it throw an error
        case "Popular":
            let popular: String = "discover/movie?sort_by=popularity.desc"
            let finalURL = URL(string: homeURL + popular + api_key)
            
            DispatchQueue.main.async {
                self.downloadJSON(finalURL: finalURL) { (result) in
                    downloadCaseCompleted(result)
                }
            }
        case "Best Dramas":
            let bestDramas: String = "discover/movie?with_genres=18&sort_by=vote_average.desc&vote_count.gte=10"
            let finalURL = URL(string: homeURL + bestDramas + api_key)
            DispatchQueue.main.async {
                self.downloadJSON(finalURL: finalURL) { (result) in
                    downloadCaseCompleted(result)
                }
            }
        case "Kids Movies":
            let kidsMovies: String = "discover/movie?certification_country=US&certification.lte=G&sort_by=popularity.desc"
            let finalURL = URL(string: homeURL + kidsMovies + api_key)
            DispatchQueue.main.async {
                self.downloadJSON(finalURL: finalURL) { (result) in
                    downloadCaseCompleted(result)
                }
            }
        case "Best Movies":
            let bestMovies: String = "discover/movie?primary_release_year=2010&sort_by=vote_average.desc"
            let finalURL = URL(string: homeURL + bestMovies + api_key)
            DispatchQueue.main.async {
                self.downloadJSON(finalURL: finalURL) { (result) in
                    downloadCaseCompleted(result)
                }
            }
        default:
            print("Error in DownloadCase")
        }
    }
}
