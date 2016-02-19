//
//  ResultsViewController.swift
//  Left
//
//  Created by Alejandrina Patron on 9/24/15.
//  Copyright © 2015 Ale Patrón. All rights reserved.
//

import UIKit

class ResultsViewController: UITableViewController {
    
    var recipes: [RecipeItem] = [
        RecipeItem(name:"Slutty Brownies", photo: "http://static.food2fork.com/BrownieFeature193f.jpg".urlToImg(), url: "http://whatsgabycooking.com/slutty-brownies/"),
        RecipeItem(name: "Easy Ice Cream Cake", photo: "http://static.food2fork.com/easyicecreamcake_300d8c35460.jpg".urlToImg(), url: "http://www.realsimple.com/food-recipes/browse-all-recipes/easy-ice-cream-cake-10000001817861/index.html"),
        RecipeItem(name: "Too Much Chocolate Cake", photo: "http://static.food2fork.com/518798fb0d.jpg".urlToImg(), url: "http://allrecipes.com/Recipe/Too-Much-Chocolate-Cake/Detail.aspx") ]
    
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
                destinationVC.recipeName = data[indexPath!.row].name
                destinationVC.recipeURL = data[indexPath!.row].url
            }
        }
    }
    
}
