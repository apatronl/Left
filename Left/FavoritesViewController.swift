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
    
    func passBackRecipe(recipe: RecipeItem) {
        favorites.append(recipe)
        self.loadView()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
//        -> UITableViewCell {
//            let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell", forIndexPath: indexPath)
//                as! RecipeCell
//            let recipe = favorites[indexPath.row] as RecipeItem
//            cell.recipe = recipe
//            return cell
//    }
}

