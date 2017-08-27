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
    static let shared = FavoritesManager()
    
    private var favoriteRecipes = [RecipeItem]()
    
    func addRecipe(recipe: RecipeItem) {
        favoriteRecipes.append(recipe)
        save()
    }
    
    func deleteRecipeAtIndex(index: Int) {
        favoriteRecipes.remove(at: index)
        save()
    }
    
    func recipeAtIndex(index: Int) -> RecipeItem? {
        return favoriteRecipes[index]
    }
    
    func recipeCount() -> Int {
        return favoriteRecipes.count
    }
    
    func archivePath() -> String? {
        let directoryList = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
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
            if FileManager.default.fileExists(atPath: theArchivePath) {
                favoriteRecipes = NSKeyedUnarchiver.unarchiveObject(withFile: theArchivePath) as! [RecipeItem]
            }
        }
    }
    
    init() {
        unarchivedSavedItems()
    }
}
