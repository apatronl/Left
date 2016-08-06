//
//  String.swift
//  Left
//
//  Created by Alejandrina Patron on 8/4/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

extension String {
    func urlToImg() -> UIImage? {
        let url = NSURL(string: self)
        if let data = NSData(contentsOfURL: url!) {
            return UIImage(data: data)
        }
        return nil
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
}