//
//  FavoritesViewController.swift
//  Left
//
//  Created by Alejandrina Patron on 9/18/15.
//  Copyright © 2015 Ale Patrón. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController {
    
    var favorites = [RecipeItem]() {
        didSet {
            tableView.reloadData()
        }
    }
    @IBOutlet weak var FavoritesTable: UITableView!
    
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

