//
//  ResultsViewController.swift
//  Left
//
//  Created by Alejandrina Patron on 9/24/15.
//  Copyright © 2015 Ale Patrón. All rights reserved.
//

import UIKit
import Toast_Swift

class ResultsViewController: UITableViewController {
    
    var data = [RecipeItem]()
    var favoriteVC: FavoritesViewController?

    @IBOutlet weak var resultsTable: UITableView!
    
    override func viewDidLoad() {
        favoriteVC = (self.tabBarController?.viewControllers![1] as! NavViewController).viewControllers[0] as? FavoritesViewController
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell", forIndexPath: indexPath)
                as! RecipeCell
            let recipe = data[indexPath.row] as RecipeItem
            cell.recipe = recipe
            return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let favoriteClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            print("Add to favorites pressed!")
            self.favoriteVC?.favoritesManager.favoriteRecipes.append(self.data[indexPath.row])
            self.favoriteVC?.tableView.reloadData()
            self.favoriteVC?.favoritesManager.save()
            
            self.navigationController?.view.makeToast("Added to favorites!", duration: 1.0, position: .Center, style: ToastManager.shared.style)
        }
        let favoriteAction = UITableViewRowAction(style: .Default, title: "\u{2605}\n Favorite", handler: favoriteClosure)
        favoriteAction.backgroundColor = UIColor.lightGrayColor()
        return [favoriteAction]
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        // Intentionally left blank. Required to use UITableViewRowActions
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "RecipeDetailView" {
            let destinationVC = segue.destinationViewController as! RecipeViewController
            if let selectedRecipe = sender as? RecipeCell {
                let indexPath = tableView.indexPathForCell(selectedRecipe)
                destinationVC.recipe = data[indexPath!.row]
                destinationVC.recipeName = data[indexPath!.row].name
                destinationVC.recipeURL = data[indexPath!.row].url
            }
        }
    }
    
}
