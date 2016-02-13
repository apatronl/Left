//
//  RequestHandler.swift
//  Left
//
//  Created by Alejandrina Patron on 2/12/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import Alamofire
import SwiftyJSON


class RequestHandler {
    
    /// Performs HTTP request with provided url
    /// - parameters:
    ///   - String: url used to perform request
    func performRequest(url: String) -> JSON? {
        var json: JSON?
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    json = JSON(value)
                    print("JSON: \(json)")
                    //print(json!["recipes"][0]["title"])
                    print(json!["count"])
//                    for ("title", title): (String, JSON!) in json {
//                        //Do something you want
//                        print(title)
//                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
        return json
    }
}


