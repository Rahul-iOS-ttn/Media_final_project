//
//  HomeScreenViewModel.swift
//  Media_final_project
//
//  Created by TTN on 02/05/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation


class HomeScreenViewModel {
    
    let api = API_integrations()
    
    var constants = DataModelConstants()
    
    var genres = ["Banner", "Popular", "Best Dramas", "Kids Movies", "Best Movies"]
    
    var genreItems: [BindedData] = []
    
    func getInformation( allDone: @escaping (Bool, String) -> Void ) {
        genreItems.removeAll()
        for genre in genres { // result functions
            
            api.downloadCase(for: genre) { (result) in
                switch result {
                case .success(let instanceData):
                    if let data = instanceData{
                        self.genreItems.append(BindedData(genre: genre, genreMovies: data))
                        allDone(true, "")
                    } else {
                        allDone(false, genre + " Data is empty")
                    }
                case .failure(let error):
//                    print(error.localizedDescription) Always on controllers
                    allDone(false, error.localizedDescription)
                }
            }
        }
    }
}
