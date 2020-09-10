//
//  HomeViewModel.swift
//  ADTPractice
//
//  Created by Sahil Reddy on 9/10/20.
//  Copyright © 2020 S Reddy. All rights reserved.
//

import Foundation

//MARK:- EpisodesViewModel
class EpisodesViewModel {
    private lazy var handler = APIHandler(urlSession: URLSession.shared)
    var episodeArray : [Episodes] = [Episodes]()
    private var error : Error?
    var pageNum = 1
    
    func getData<T:Codable>(_ pageNum: Int,_ typeWeNeed: T.Type, completionHandler: @escaping CompletionHandler) {
        handler.getData(Constants.DomainURL + Constants.page + String(pageNum), Page.self) { (data, response, error) in
            let info = data as? Page
            let newArr = info?.results ?? []
            self.setArray(newArr)
            self.error = error
            completionHandler(data,response,error)
        }
    }
    
    func getArrayCount()->Int{
        return episodeArray.count
    }
    func clearData() {
        episodeArray.removeAll()
    }
    
    func getIndexOfArray(_ index: Int)->Episodes{
        return episodeArray[index]
    }
    
    func setArray(_ array: [Episodes]) {
        self.episodeArray += array
    }
}
