//
//  Constants.swift
//  ADTPractice
//
//  Created by Sahil Reddy on 9/10/20.
//  Copyright © 2020 S Reddy. All rights reserved.
//

import Foundation

//MARK:- Constants
struct Constants {
    static let DomainURL =  "https://rickandmortyapi.com/api/episode/"
    static let page = "?page="
    static let cell = "cell"
    static let EpisodesPageTitle = "Rick and Morty Episodes"
    static let notAvailable = "N/A"
    static let placeholder = "placeholder"
    
    struct vc {
        static let episodesVC = "EpisodesViewController"
        static let characterVC = "CharacterViewController"
        static let characterDetailVC = "CharacterDetailViewController"
        static let main = "Main"
    }
    
    struct DatabaseManager {
        static let projectName = "ADTPractice"
        static let episodeEntity = "EpisodesEntity"
        static let dataSaved = "Data Saved to Context"
    }
    
    struct DatabaseKey {
        static let name = "name"
        static let website = "www.google.com"
    }
    
    struct CustomError {
        
    }
}
