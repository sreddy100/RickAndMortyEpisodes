//
//  EpisodeViewModel.swift
//  ADTPractice
//
//  Created by Sahil Reddy on 9/10/20.
//  Copyright © 2020 S Reddy. All rights reserved.
//

import Foundation

class CharacterViewModel {
    private lazy var handler = APIHandler(urlSession: URLSession.shared)
    private var charArr : [Characters] = [Characters]()
    private lazy var stringCharArr : [String] = [String]()
    
    //get Characters from the given URL list
    func getCharacters(_ urlString: String, completionHandler: @escaping CompletionHandler) {
        handler.getData(urlString, Characters.self) { (data, response, error) in
            let info = data as? Characters
            self.addToArray(info)
            
        }
    }
    
    func addToArray(_ ch: Characters?) {
        if let ch = ch {
            self.charArr.append(ch)
        }
    }
    
    func getIndexOfArr(_ index: Int)->Characters{
        return self.charArr[index]
    }
    
    func getArrCount()->Int {
        return charArr.count
    }
    func clearData() {
        charArr.removeAll()
    }
    
}
