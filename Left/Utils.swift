//
//  Utils.swift
//  Left
//
//  Created by Alejandrina Patron on 4/12/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit

extension String {
    func urlToImg() -> UIImage? {
        let url = NSURL(string: self)
        if let data = NSData(contentsOfURL: url!) {
            return UIImage(data: data)
        }
        return nil
    }
}

extension String {
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}