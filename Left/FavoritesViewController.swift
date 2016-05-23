//
//  FavoritesViewController.swift
//  Left
//
//  Created by Alejandrina Patron on 9/18/15.
//  Copyright © 2015 Ale Patrón. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController {
    
    var favoritesManager = FavoritesManager()
    
    @IBOutlet weak var FavoritesTable: UITableView!
    
    override func viewDidLoad() {
        self.navigationItem.leftBarButtonItem = editButtonItem()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesManager.favoriteRecipes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell = tableView.dequeueReusableCellWithIdentifier("FavoriteRecipeCell", forIndexPath: indexPath)
                as! FavoriteRecipeCell
            let recipe = favoritesManager.favoriteRecipes[indexPath.row] as RecipeItem
            cell.recipe = recipe
            
            let background = UIImageView(image: recipe.photo)
            cell.backgroundView = background
            let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
            visualEffectView.frame = CGRectMake(0, 0, cell.bounds.width, cell.bounds.height)
            background.addSubview(visualEffectView)
            
            return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            favoritesManager.favoriteRecipes.removeAtIndex(indexPath.row)
            favoritesManager.save()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let recipe = favoritesManager.favoriteRecipes[indexPath.row]
//        let safari = SFSafariViewController(URL: NSURL(string: recipe.url)!)
//        safari.view.tintColor = UIColor(red: 153.0/255.0, green: 51.0/255.0, blue:255.0/255.0, alpha: 1.0)
//        presentViewController(safari, animated: true, completion: nil)
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "FavoriteRecipeDetailView") {
            let destinationVC = segue.destinationViewController as! FavoriteRecipeViewController
            if let selectedRecipe = sender as? FavoriteRecipeCell {
                let indexPath = tableView.indexPathForCell(selectedRecipe)
                destinationVC.recipe = favoritesManager.favoriteRecipes[indexPath!.row]
            }
        }
    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        let itemToMove = favoritesManager.favoriteRecipes[fromIndexPath.row]
        favoritesManager.favoriteRecipes.removeAtIndex(fromIndexPath.row)
        favoritesManager.favoriteRecipes.insert(itemToMove, atIndex: toIndexPath.row)
        favoritesManager.save()
    }
    
    func blurImage(imageView: UIImageView) -> UIImageView {
        let blur = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = imageView.frame
        imageView.addSubview(blurView)
        return imageView
    }
}

