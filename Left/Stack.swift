//
//  Stack.swift
//  Left
//
//  Created by Alejandrina Patron on 4/14/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import Foundation

class Stack<Element> {
    var items = [Element]()
    
    func push(item: Element) {
        items.append(item)
    }
    
    func pop() -> Element {
        return items.removeLast()
    }
    
    func size() -> Int {
        return items.count
    }
}
