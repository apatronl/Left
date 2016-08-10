//
//  SearchTableView.swift
//  Left
//
//  Created by Alejandrina Patron on 8/6/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit

class SearchTableView: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    private let textFieldPlaceholder = "Type an ingredient and press +"
    private var ingredients = [String]()
    
    // TODO: Add "What do you have Left today?" when table is empty
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        textField.placeholder = textFieldPlaceholder
        textField.tintColor = UIColor.blackColor()
        
        searchButtonEnabled()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchTableView.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "resultsSegue" {
            let destinationVC = segue.destinationViewController as! ResultsCollectionView
            destinationVC.ingredients = ingredients
        }
    }
    
    // MARK: IBAction
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        if let ingredient = textField.text {
            let trimmedIngredient = ingredient.trim()
            if !trimmedIngredient.isEmpty {
                print(trimmedIngredient)
                self.ingredients.append(trimmedIngredient)
                self.tableView.reloadData()
                self.textField.text = ""
                self.textField.placeholder = textFieldPlaceholder
                dismissKeyboard()
                searchButtonEnabled()
            }
        }
    }
    
    @IBAction func searchButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("resultsSegue", sender: sender)
    }
    
    // MARK: Table View Delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let cell  = tableView.dequeueReusableCellWithIdentifier("ingredientCell") as! IngredientCell
            cell.ingredient = ingredients[indexPath.row]
            return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            ingredients.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            searchButtonEnabled()
        }
    }
    
    // MARK: Helper
    
    func dismissKeyboard() {
        self.view.endEditing(true)
        textField.resignFirstResponder()
    }
    
    func searchButtonEnabled() {
        if ingredients.count > 0 {
            searchButton.enabled = true
            searchButton.backgroundColor = UIColor.LeftColor()
        } else {
            searchButton.enabled = false
            searchButton.backgroundColor = UIColor.lightGrayColor()
        }
    }
}

// MARK: UITableViewCell

class IngredientCell: UITableViewCell {
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    var ingredient: String! {
        didSet {
            self.ingredientLabel.text = ingredient
        }
    }
}