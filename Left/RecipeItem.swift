//
//  RecipeItem.swift
//  Left
//
//  Created by Alejandrina Patron on 11/4/15.
//  Copyright © 2015 Ale Patrón. All rights reserved.
//

import Foundation
import UIKit

public class RecipeItem: NSObject {
    var name: String
    var photo: UIImage?
    var url: String
    var photoUrl: String?
    
    let nameKey = "name"
    let photoKey = "photo"
    let urlKey = "url"
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: nameKey)
        if let thePhoto = photo {
            aCoder.encodeObject(thePhoto, forKey: photoKey)
        }
        aCoder.encodeObject(url, forKey: urlKey)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey(nameKey) as! String
        photo = aDecoder.decodeObjectForKey(photoKey) as? UIImage
        url = aDecoder.decodeObjectForKey(urlKey) as! String
    }
    
    init(name: String, photo: UIImage?, url: String) {
        self.name = name
        self.photo = photo
        self.url = url
    }
    
    init(name: String, photoUrl: String?, photo: UIImage?, url: String) {
        self.name = name
        self.photoUrl = photoUrl
        self.photo = photo
        self.url = url
    }
}
