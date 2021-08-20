//
//  DataModel.swift
//  Media_final_project
//
//  Created by TTN on 28/04/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation


struct BindedData {
    var genre: String
    var genreMovies: [MovieData]
}

struct MainData : Decodable {
    var page:Int?
    var results: [MovieData]?
    var total_pages: Int?
    var total_results: Int?
}

struct MovieData : Decodable {
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var poster_path: String?
    var release_date: String?
    var title: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
}

class DataModelConstants {
    
    /// URL for getting access to the keys: https://api.themoviedb.org/3/genre/movie/list?api_key=820016b7116f872f5f27bf56f9fdfb66&language=en-US
    var genreName: [Int: String] = [28:"Action", 12: "Adventure", 16: "Animation", 35: "Comedy", 80:"Crime", 99:"Documentary", 18:"Drama", 10751: "Family", 14: "Fantasy", 36: "History", 27: "Horror", 10402: "Music", 9648: "Mystery", 10749: "Romance", 878: "Science Fiction", 10770: "TV Movie", 53: "Thriller", 10752: "War", 37: "Western"]
}
