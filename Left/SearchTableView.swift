//
//  SearchTableView.swift
//  Left
//
//  Created by Alejandrina Patron on 8/6/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class SearchTableView: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    let textFieldPlaceholder = "Type an ingredient and press +"
    var ingredients = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subscribeToKeyboardNotifications()
        
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        self.tableView.dataSource = self
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        textField.placeholder = textFieldPlaceholder
        textField.tintColor = UIColor.LeftColor()
        textField.delegate = self
        
        searchButtonEnabled()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchTableView.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        unsubscribeFromKeyboardNotifications()
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultsSegue" {
            let destinationVC = segue.destination as! ResultsCollectionView
            destinationVC.ingredients = ingredients
        }
    }
    
    // MARK: IBAction
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        addIngreditent()
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        dismissKeyboard()
        performSegue(withIdentifier: "resultsSegue", sender: sender)
    }
    
    // MARK: Table View Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ingredientCell") as! IngredientCell
        cell.ingredient = ingredients[indexPath.row]
        
        // Handle delete button action
        cell.deleteButton.layer.setValue(indexPath.row, forKey: "index")
        cell.deleteButton.addTarget(self, action: #selector(SearchTableView.deleteIngredient(sender:)), for: UIControlEvents.touchUpInside)
        
        return cell
    }
    
    // MARK: Text Field Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        addIngreditent()
        return true
    }
    
    // MARK: DZNEMptyDataSet Delegate
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "placeholder-search")
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let message = "What do you have Left today?"
        let attribute = [NSForegroundColorAttributeName: UIColor.lightGray, NSFontAttributeName: UIFont(name: "HelveticaNeue", size: 22.0)!]
        return NSAttributedString(string: message, attributes: attribute)
    }
    
    
    // MARK: Helper
    
    func dismissKeyboard() {
        self.view.endEditing(true)
        textField.resignFirstResponder()
    }
    
    func searchButtonEnabled() {
        if ingredients.count > 0 {
            searchButton.isEnabled = true
            searchButton.backgroundColor = UIColor.LeftColor()
        } else {
            searchButton.isEnabled = false
            searchButton.backgroundColor = UIColor.lightGray
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
        let index: Int = (sender.layer.value(forKey: "index")) as! Int
        ingredients.remove(at: index)
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
