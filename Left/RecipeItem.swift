//
//  RecipeItem.swift
//  Left
//
//  Created by Alejandrina Patron on 11/4/15.
//  Copyright © 2015 A(pps)PL. All rights reserved.
//

import Foundation
import UIKit

class RecipeItem: NSObject {
    let name: String
    let photo: UIImage?
    
    init(name: String, photo: UIImage) {
        self.name = name
        self.photo = photo
    }
}
