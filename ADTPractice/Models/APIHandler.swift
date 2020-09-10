//
//  APIHandler.swift
//  ADTPractice
//
//  Created by Sahil Reddy on 9/10/20.
//  Copyright © 2020 S Reddy. All rights reserved.
//

import Foundation

typealias CompletionHandler = ((Any?, URLResponse?, Error?)->Void)

class APIHandler {
    var urlSession : URLSession
    //initialize session
    init(urlSession : URLSession) {
        self.urlSession = urlSession
    }
    
    //get Data using Codable
    func getData<T:Codable>(_ urlString: String,_ typeWeNeed: T.Type, completionHandler: @escaping CompletionHandler ) {
        guard let url = URL(string: urlString) else {completionHandler(nil,nil,nil); return}
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if data != nil {
                do {
                    let model = try JSONDecoder().decode(typeWeNeed.self, from: data!)
                    completionHandler(model,response,nil)
                    
                }catch{
                    completionHandler(nil,response,error)
                }
            } else {
                completionHandler(nil, response, error)
            }
        }.resume()
    }
    
}