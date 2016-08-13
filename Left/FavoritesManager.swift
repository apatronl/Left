//
//  FavoritesManager.swift
//  Left
//
//  Created by Alejandrina Patron on 3/4/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import Foundation

class FavoritesManager {
    
    // Singleton
    static let sharedInstance = FavoritesManager()
    
    private var favoriteRecipes = [RecipeItem]()
    
    func addRecipe(recipe: RecipeItem) {
        favoriteRecipes.append(recipe)
        save()
    }
    
    func deleteRecipeAtIndex(index: Int) {
        favoriteRecipes.removeAtIndex(index)
        save()
    }
    
    func recipeAtIndex(index: Int) -> RecipeItem? {
        return favoriteRecipes[index]
    }
    
    func recipeCount() -> Int {
        return favoriteRecipes.count
    }
    
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
