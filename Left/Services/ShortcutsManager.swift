//
//  ShortcutsManager.swift
//  Left
//
//  Created by Alejandrina Patron on 6/11/17.
//  Copyright © 2017 Ale Patrón. All rights reserved.
//

import Foundation

struct ShortcutsManager {
    
    static func updateCount(for recipe: RecipeItem) {
        
    }
    
    static func removeFromDefaults(at index: Int) {
        // 3D touch available iOS 9.0+
//        if #available(iOS 9.0, *) {
//            let data = UserDefaults.standard
//            var dict: [String : Int] = data.dictionary(forKey: RecipeOpenCountKey) as? [String : Int] ?? [ : ]
//            let recipeKey = "\(self.name)~~\(self.url)"
//            dict.removeValue(forKey: recipeKey)
//            data.set(dict, forKey: RecipeOpenCountKey)
//            
//            RecipeItem.updateShortcutItems()
//        }
    }
    
    static func updateShortcutItems() {
    
    }
    
}
