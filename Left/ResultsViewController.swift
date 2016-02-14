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
        RecipeItem(name:"Slutty Brownies", photo: "http://static.food2fork.com/BrownieFeature193f.jpg".urlToImg(), url: "http://facebook.com"),
        RecipeItem(name: "Easy Ice Cream Cake", photo: nil, url: "http://facebook.com"),
        RecipeItem(name: "Too Much Chocolate Cake", photo: nil, url: "http://facebook.com") ]

    @IBOutlet weak var resultsTable: UITableView!
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell", forIndexPath: indexPath)
                as! RecipeCell
            
            let recipe = recipes[indexPath.row] as RecipeItem
            cell.recipe = recipe
            return cell
    }
    
}

extension String {
    func urlToImg() -> UIImage? {
        let url = NSURL(string: self)
        if let data = NSData(contentsOfURL: url!) {
            return UIImage(data: data)
        }
        return nil
    }
}

//class RecipesData {
//    let recipesData = [
//        RecipeItem(name:"Brownies", url: "http://facebook.com"),
//        RecipeItem(name: "Easy Ice Cream Cake", url: "http://facebook.com"),
//        RecipeItem(name: "Too Much Chocolate Cake", url: "http://facebook.com") ]
//}
