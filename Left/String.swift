//
//  String.swift
//  Left
//
//  Created by Alejandrina Patron on 8/4/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

extension String {
    
    func verifyRecipeName() -> String {
        var verifiedString = self
        verifiedString = verifiedString.stringByReplacingOccurrencesOfString("&amp;", withString: "&")
        verifiedString = verifiedString.stringByReplacingOccurrencesOfString("&#8217;", withString: "'")
        verifiedString = verifiedString.stringByReplacingOccurrencesOfString("&#8482;", withString: "®")
        verifiedString = verifiedString.stringByReplacingOccurrencesOfString("&nbsp;", withString: " ")
        
        return verifiedString
    }
    
    func urlToImg(completion: (UIImage?) -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let url = NSURL(string: self)
            if let data = NSData(contentsOfURL: url!) {
                if let image = UIImage(data: data) {
                    dispatch_async(dispatch_get_main_queue(), {
                        completion(image)
                    })
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    completion(nil)
                })
            }
        })
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
}