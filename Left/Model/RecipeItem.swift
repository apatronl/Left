//
//  RecipeItem.swift
//  Left
//
//  Created by Alejandrina Patron on 11/4/15.
//  Copyright © 2015 Ale Patrón. All rights reserved.
//

import UIKit

let RecipeOpenCountKey = "recipeOpenCount"

class RecipeItem: NSObject {
    var name: String
    var photo: UIImage?
    var url: String
    var photoUrl: String?
    
    let nameKey = "name"
    let photoKey = "photo"
    let urlKey = "url"
    
    func encodeWithCoder(_ aCoder: NSCoder) {
        aCoder.encode(name, forKey: nameKey)
        if let thePhoto = photo {
            aCoder.encode(thePhoto, forKey: photoKey)
        }
        aCoder.encode(url, forKey: urlKey)
    }
    
    required internal init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: nameKey) as! String
        photo = aDecoder.decodeObject(forKey: photoKey) as? UIImage
        url = aDecoder.decodeObject(forKey: urlKey) as! String
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
    
    // MARK: 3D touch quick actions
    
    func updateOpenCount() {
        if #available(iOS 9.0, *) {
            let data = UserDefaults.standard
            var dict: [String : Int] = data.dictionary(forKey: RecipeOpenCountKey) as? [String : Int] ?? [:]
            let key = "\(self.name)~~\(self.url)"
            let previousCount = dict[key] ?? 0
            dict.updateValue(previousCount + 1, forKey: key)
            data.set(dict, forKey: RecipeOpenCountKey)
            
            RecipeItem.updateShortcutItems()
        }
    }
    
    func removeFromDefaults(index: Int) {
        // 3D touch available iOS 9.0+
        if #available(iOS 9.0, *) {
            let data = UserDefaults.standard
            var dict: [String : Int] = data.dictionary(forKey: RecipeOpenCountKey) as? [String : Int] ?? [ : ]
            let recipeKey = "\(self.name)~~\(self.url)"
            dict.removeValue(forKey: recipeKey)
            data.set(dict, forKey: RecipeOpenCountKey)
            
            RecipeItem.updateShortcutItems()
        }
    }
    
    static func updateShortcutItems() {
        if #available(iOS 9.0, *) {
            let data = UserDefaults.standard
            let dict: [String : Int] = data.dictionary(forKey: RecipeOpenCountKey) as? [String : Int] ?? [ : ]
            let sortedDict = dict.sorted{ $0.1 > $1.1 }
            var shortcuts: [UIApplicationShortcutItem] = []
            
            for i in 0..<min(4, sortedDict.count) {
                let (key, _) = sortedDict[i]
                let splitKey = key.components(separatedBy: "~~")
                
                let recipeName = splitKey[0]
                let recipeURL = splitKey[1]
                
                let info = ["NAME" : recipeName, "URL" : recipeURL]
                let shortcut = UIApplicationShortcutItem(type: "openRecipe", localizedTitle: recipeName, localizedSubtitle: nil, icon: nil, userInfo: info)
                shortcuts.append(shortcut)
            }
            
            UIApplication.shared.shortcutItems = shortcuts
        }
    }
}
