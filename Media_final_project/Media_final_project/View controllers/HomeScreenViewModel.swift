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
    
    var genreItems: [BindedData] = [BindedData(genre: "Banner", genreMovies: []), BindedData(genre: "Popular", genreMovies: []),BindedData(genre: "Best Dramas", genreMovies: []),BindedData(genre: "Kids Movies", genreMovies: []),BindedData(genre: "Best Movies", genreMovies: []),
    ]
    
    func getInformation( allDone: @escaping (Bool, String) -> Void ) {
        for (index, genreItem) in genreItems.enumerated() { // result functions
            
            api.DownloadCase(for: genreItem.genre) { (result) in
                switch result {
                case .success(let instanceData):
                    self.genreItems[index].genreMovies = instanceData
                    if index == self.genreItems.count - 1 {
                        allDone(true, "")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    allDone(false, error.localizedDescription)
                }
            }
        }
    }
}
