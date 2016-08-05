//
//  ResultsViewController.swift
//  Left
//
//  Created by Alejandrina Patron on 9/24/15.
//  Copyright © 2015 Ale Patrón. All rights reserved.
//

import UIKit
import Toast_Swift
import Alamofire
import SwiftyJSON

class ResultsViewController: UITableViewController {
    
    let hud = MBProgressHUD()
    var favoriteVC: FavoritesViewController?
    var dataSource: RecipeDataSource!
    
    @IBOutlet weak var resultsTable: UITableView!
    
    override func viewDidLoad() {
        favoriteVC = (self.tabBarController?.viewControllers![1] as! NavViewController).viewControllers[0] as? FavoritesViewController
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        // Set up activity indicator
        hud.labelText = "Loading..."
        hud.labelFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)!
        hud.color = UIColor.whiteColor()
        hud.labelColor = UIColor(red: 153.0/255.0, green: 51.0/255.0, blue:255.0/255.0, alpha: 1.0)
        hud.activityIndicatorColor = UIColor(red: 153.0/255.0, green: 51.0/255.0, blue:255.0/255.0, alpha: 1.0)
        UIApplication.sharedApplication().keyWindow?.addSubview(hud)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return dataSource.recipes.count
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 95
            
        case 1:
            return 45
            
        default:
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("RecipeCell", forIndexPath: indexPath)
                    as! RecipeCell
                
                let recipe = dataSource.recipes[indexPath.row] as RecipeItem
                cell.recipe = recipe
                if recipe.photo != nil {
                    let background = UIImageView(image: recipe.photo)
                    cell.backgroundView = background
                    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
                    visualEffectView.frame = CGRectMake(0, 0, cell.bounds.width, cell.bounds.height)
                    background.addSubview(visualEffectView)
                }
                
//                let background = UIImageView(image: recipe.photo)
//                cell.backgroundView = background
//                let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .ExtraLight)) as UIVisualEffectView
//                visualEffectView.frame = CGRectMake(0, 0, cell.bounds.width, cell.bounds.height)
//                background.addSubview(visualEffectView)
                
                return cell
                
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier(MoreCell.reuseIdentifier, forIndexPath: indexPath) as! MoreCell
                cell.layoutMargins = UIEdgeInsetsZero
                return cell
            }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 1:
            self.hud.show(true)
            print("HUD!")
            Alamofire.request(.GET, dataSource.url + "&page=" + String(dataSource.page)).validate().responseJSON { response in
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        var res = JSON(value)
                        print(Int(String(res["count"]))!)
                        let count = Int(String(res["count"]))!
                        if count > 0 {
                            for i in 0...count - 1 {
                                if let name = res["recipes"][i]["title"].string {
                                    let url: String = res["recipes"][i]["source_url"].string!
                                    let photo: UIImage? = res["recipes"][i]["image_url"].string!.urlToImg()
                                    let curr: RecipeItem = RecipeItem(name: name, photo: photo, url: url)
                                    self.dataSource.recipes.append(curr)
                                }
                            }
                        }
                        self.tableView.reloadData()
                    }
                    self.dataSource.page += 1
                    self.hud.hide(true)
                case .Failure(let error):
                    self.hud.hide(true)
                    print(error)
                }
            }
        default:
            return
        }
    }
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let favoriteClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            print("Add to favorites pressed!")
            self.favoriteVC?.favoritesManager.favoriteRecipes.append(self.dataSource.recipes[indexPath.row])
            self.favoriteVC?.tableView.reloadData()
            self.favoriteVC?.favoritesManager.save()
            
            self.navigationController?.view.makeToast("Added to favorites!", duration: 1.0, position: .Center, style: ToastManager.shared.style)
        }
        let favoriteAction = UITableViewRowAction(style: .Default, title: "\u{2605}\n Favorite", handler: favoriteClosure)
        favoriteAction.backgroundColor = UIColor(red: 243.0/255.0, green: 220.0/255.0, blue: 68.0/255.0, alpha: 1.0)
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
                destinationVC.recipe = dataSource.recipes[indexPath!.row]
                destinationVC.recipeName = dataSource.recipes[indexPath!.row].name
                destinationVC.recipeURL = dataSource.recipes[indexPath!.row].url
            }
        }
    }
}
