//
//  FavoritesViewController.swift
//  Left
//
//  Created by Alejandrina Patron on 9/18/15.
//  Copyright © 2015 Ale Patrón. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController, UpdateFavorites {
    
    var favorites = [RecipeItem]()
    @IBOutlet weak var FavoritesTable: UITableView!
    var rvc: RecipeViewController = RecipeViewController()
    
    func passBackRecipe(recipe: RecipeItem) {
        favorites.append(recipe)
        print(recipe.name)
        self.loadView()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("FavoriteRecipeCell", forIndexPath: indexPath)
                as! FavoriteRecipeCell
            let recipe = favorites[indexPath.row] as RecipeItem
            cell.recipe = recipe
            return cell
    }
}

