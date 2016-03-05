//
//  FavoritesManager.swift
//  Left
//
//  Created by Alejandrina Patron on 3/4/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import Foundation

class FavoritesManager {
    var favoriteRecipes = [RecipeItem]()
    
    func archivePath() -> String? {
        let directoryList = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        if let documentsPath = directoryList.first {
            return documentsPath + "/Favorites"
        }
        assertionFailure("Could not determine where to save file.")
        return nil
    }
    
    func save() {
        if let theArchivePath = archivePath() {
            if NSKeyedArchiver.archiveRootObject(favoriteRecipes, toFile: theArchivePath) {
                print("We saved!")
            } else {
                assertionFailure("Could not save to \(theArchivePath)")
            }
        }
    }
    
    func unarchivedSavedItems() {
        if let theArchivePath = archivePath() {
            if NSFileManager.defaultManager().fileExistsAtPath(theArchivePath) {
                favoriteRecipes = NSKeyedUnarchiver.unarchiveObjectWithFile(theArchivePath) as! [RecipeItem]
            }
        }
    }
    
    init() {
        unarchivedSavedItems()
    }
}
