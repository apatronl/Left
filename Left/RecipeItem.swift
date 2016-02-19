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
    var name: String
    var photo: UIImage?
    var url: String
    
    init(name: String, photo: UIImage?, url: String) {
        self.name = name
        self.photo = photo
        self.url = url
    }
}
