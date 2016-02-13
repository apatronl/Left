//
//  RecipeItem.swift
//  Left
//
//  Created by Alejandrina Patron on 11/4/15.
//  Copyright © 2015 Ale Patrón. All rights reserved.
//

import Foundation
import UIKit

class RecipeItem: NSObject {
    let name: String
    //let photo: UIImage?
    let url: String
//    init(name: String, photo: UIImage, url: String) {
//        self.name = name
//        self.photo = photo
//        self.url = url
//    }
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
