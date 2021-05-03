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
    
}
