//
//  APIHelper.swift
//  PinboardDemo
//
//  Created by SYED FARAN GHANI on 23/09/19.
//  Copyright © 2019 Syed Faran Ghani. All rights reserved.
//

import UIKit

/// HTTP method definitions.

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

class APIHelper: NSObject {

    static let shared = APIHelper()
    
    let session = URLSession(configuration: .default)

    func getRequest(urlString: String, completionBlock: @escaping (_ success: Bool, _ result: Any) -> ()){
        
        if let urlComponent = URLComponents.init(string: urlString){
            
            guard let url = urlComponent.url else { return }
            
            let dataTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    if let error = error {
                        completionBlock(false, error)
                    }
                        
                    else if let data = data , let response = response as? HTTPURLResponse{
                        
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []){
                            
                            if response.statusCode == 200{
                                
                                completionBlock(true, json)
                            }
                        }
                    }
                }
                
            })
            dataTask.resume()
        }
    }
    
}
