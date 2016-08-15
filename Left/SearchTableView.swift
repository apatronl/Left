//
//  SearchTableView.swift
//  Left
//
//  Created by Alejandrina Patron on 8/6/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class SearchTableView: UIViewController, UITableViewDelegate, UITextFieldDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    private let textFieldPlaceholder = "Type an ingredient and press +"
    private var ingredients = [String]()
    
    // TODO: Add "What do you have Left today?" when table is empty
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        
        textField.placeholder = textFieldPlaceholder
        textField.tintColor = UIColor.blackColor()
        textField.delegate = self
        
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
        addIngreditent()
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
            
            // Handle delete button action
            cell.deleteButton.layer.setValue(indexPath.row, forKey: "index")
            cell.deleteButton.addTarget(self, action: #selector(SearchTableView.deleteIngredient(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            return cell
    }
    
    // MARK: Text Field Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        addIngreditent()
        return true
    }
    
    // MARK: DZNEMptyDataSet Delegate
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "placeholder-search")
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let message = "What do you have Left today?"
        let attribute = [NSForegroundColorAttributeName: UIColor.lightGrayColor(), NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 22.0)!]
        return NSAttributedString(string: message, attributes: attribute)
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
    
    func addIngreditent() {
        if let ingredient = textField.text {
            let trimmedIngredient = ingredient.trim()
            if !trimmedIngredient.isEmpty {
                self.ingredients.append(trimmedIngredient)
                self.tableView.reloadData()
                self.textField.text = ""
                self.textField.placeholder = textFieldPlaceholder
                dismissKeyboard()
                searchButtonEnabled()
            }
        }
    }
    
    func deleteIngredient(sender: UIButton) {
        let index: Int = (sender.layer.valueForKey("index")) as! Int
        ingredients.removeAtIndex(index)
        tableView.reloadData()
        searchButtonEnabled()
    }
}

// MARK: UITableViewCell

class IngredientCell: UITableViewCell {
    
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var ingredient: String! {
        didSet {
            self.ingredientLabel.text = ingredient
        }
    }
}