//
//  APIHandler.swift
//  ADTPractice
//
//  Created by Sahil Reddy on 9/10/20.
//  Copyright © 2020 S Reddy. All rights reserved.
//

import Foundation
import SystemConfiguration

typealias CompletionHandler = ((Any?, URLResponse?, Error?)->Void)

//MARK:-APIHandler
class APIHandler {
    var urlSession : URLSession
    //initialize session
    init(urlSession : URLSession) {
        self.urlSession = urlSession
    }
    
    func getData<T:Codable>(_ urlString: String,_ typeWeNeed: T.Type, completionHandler: @escaping CompletionHandler ) {
        guard let url = URL(string: urlString) else {completionHandler(nil,nil,nil); return}
        
        urlSession.dataTask(with: url) { (data, response, error) in
            if data != nil {
                do {
                    let model = try JSONDecoder().decode(typeWeNeed.self, from: data!)
                    //For core data
                    if let newModel = model as? Page{
                        DatabaseManager.addEpisodesToCoreData((newModel.results)!)
                    }
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





