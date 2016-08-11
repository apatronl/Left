//
//  String.swift
//  Left
//
//  Created by Alejandrina Patron on 8/4/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

extension String {
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
    
}