//
//  ResultsViewController.swift
//  Left
//
//  Created by Alejandrina Patron on 9/24/15.
//  Copyright © 2015 Ale Patrón. All rights reserved.
//

import UIKit

class ResultsViewController: UITableViewController {
    
    var data = [RecipeItem]()

    @IBOutlet weak var resultsTable: UITableView!
    
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
