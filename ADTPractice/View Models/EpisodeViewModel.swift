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
    private lazy var charArr : [Characters] = [Characters]()
    
    //get Characters from the given URL list
    func getCharacters(_ urlString: String, completionHandler: @escaping CompletionHandler) {
        handler.getData(urlString, [Characters].self) { (data, response, error) in
            let info = data as? [Characters]
            self.setArray(info ?? [])
            
        }
    }
    
    func setArray(_ array: [Characters]) {
        self.charArr += array
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
