//
//  SearchViewController.swift
//  Left
//
//  Created by Alejandrina Patron on 9/18/15.
//  Copyright © 2015 Ale Patrón. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    //    static let appKey: String = "{YOUR_API_KEY}"
    //    static let appID: String = "82104c57"
    //    let url: String = "https://api.edamam.com/search?app_id=" + appID + "&app_key=" + appKey + "&from=0&to=100&q="

    @IBOutlet weak var ingredient1: UITextField!
    @IBOutlet weak var ingredient2: UITextField!
    @IBOutlet weak var ingredient3: UITextField!
    @IBOutlet weak var ingredient4: UITextField!
    @IBOutlet weak var ingredient5: UITextField!
    
    static let apiKey: String = "YOUR_API_KEY"
    let url: String = "http://food2fork.com/api/search?key=" + apiKey + "&q="
    let hud = MBProgressHUD()
    
    var ingredients = [String]()
    
    var dataSource = RecipeDataSource()
    let bgColor: UIColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue:245.0/255.0, alpha: 1.0)
    var numOfIngredients: Int = 1
    
    @IBAction func add(sender: UIButton) {
        if (numOfIngredients <= 5) {
            numOfIngredients += 1
        }
        switch numOfIngredients {
        case 2:
            ingredient2.hidden = false
        case 3:
            ingredient3.hidden = false
        case 4:
            ingredient4.hidden = false
        case 5:
            ingredient5.hidden = false
        default:
            showAlert("moreThanFiveIngredients")
        }
    }
    
    @IBAction func remove(sender: UIButton) {
            switch numOfIngredients {
        case 2:
            ingredient2.hidden = true
            ingredient2.text = ""
            numOfIngredients -= 1
        case 3:
            ingredient3.hidden = true
            ingredient3.text = ""
            numOfIngredients -= 1
        case 4:
            ingredient4.hidden = true
            ingredient4.text = ""
            numOfIngredients -= 1
        case 5:
            ingredient5.hidden = true
            ingredient5.text = ""
            numOfIngredients -= 1
        case 6:
            ingredient5.hidden = true
            ingredient5.text = ""
            numOfIngredients -= 1
        default:
            showAlert("atLeastOneIngredient")
        }
        
    }
    
    
    @IBAction func resignKeyboard(sender: AnyObject) {
        sender.resignFirstResponder()
    }

    @IBAction func searchButtonPressed(sender: UIButton) {
        hud.show(true)
        dataSource.recipes.removeAll()
        if let ing1 = ingredient1.text {
            ingredients.append(ing1.trim())
        }
        if (ingredient2.hidden == false) {
            if let ing2 = ingredient2.text {
                if (ing2 != "") {
                    ingredients.append(ing2.trim())
                }
            }
        }
        if (ingredient3.hidden == false) {
            if let ing3 = ingredient3.text {
                if (ing3 != "") {
                    ingredients.append(ing3.trim())
                }
            }
        }
        if (ingredient4.hidden == false) {
            if let ing4 = ingredient4.text {
                if (ing4 != "") {
                    ingredients.append(ing4.trim())
                }
            }
        }
        if (ingredient5.hidden == false) {
            if let ing5 = ingredient5.text {
                if (ing5 != "") {
                    ingredients.append(ing5.trim())
                }
            }
        }
        let length: Int = ingredients.count
        var urlWithIngredients: String = url
        for i in 0...length - 1 {
            if (i == 0) {
                urlWithIngredients += ingredients.first!
                urlWithIngredients = urlWithIngredients.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            } else {
                urlWithIngredients += "," + ingredients[i]
                urlWithIngredients = urlWithIngredients.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            }
        }
        ingredients.removeAll()
        print(urlWithIngredients)
        
        dataSource.url = urlWithIngredients
//        self.progressView.hidden = false
        
        
// MARK: - Food2Fork Request Handling
        
//        let request = Alamofire.request(.GET, urlWithIngredients)
//        request.progress { _, _, _ in
//            dispatch_async(dispatch_get_main_queue()) {
//                self.progressView.setProgress(Float(request.progress.fractionCompleted), animated: true)
//            }
//        }
        
//        request.responseJSON { response in
//            switch response.result {
//            case .Success:
//                if let value = response.result.value {
//                    var res = JSON(value)
//                    print(Int(String(res["count"]))!)
//                    let count = Int(String(res["count"]))!
//                    if count > 0 {
//                        for i in 0...count - 1 {
//                            if let name = res["recipes"][i]["title"].string {
//                                let url: String = res["recipes"][i]["source_url"].string!
//                                let photo: UIImage? = res["recipes"][i]["image_url"].string!.urlToImg()
//                                let curr: RecipeItem = RecipeItem(name: name, photo: photo, url: url)
//                                self.dataSource.recipes.append(curr)
//                            }
//                        }
//                    }
//                    if (count > 0) {
//                        self.performSegueWithIdentifier("resultsSegue", sender: self)
//                    } else {
//                        self.showAlert("noResults")
//                    }
//                }
//            case .Failure(let error):
//                self.showAlert("searchFailure")
//                print(error)
//            }
//            self.progressView.setProgress(0.0, animated: true)
//            self.progressView.hidden = true
//        }
        
        ////////////////
        
        Alamofire.request(.GET, urlWithIngredients).validate().responseJSON { response in
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
                    if (count > 0) {
                        self.performSegueWithIdentifier("resultsSegue", sender: self)
                    } else {
                        self.showAlert("noResults")
                    }
                }
                self.hud.hide(true)
            case .Failure(let error):
                self.hud.hide(true)
                self.showAlert("searchFailure")
                print(error)
            }
        }

        
        ////////////////
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "resultsSegue" {
            let destinationVC = segue.destinationViewController as! ResultsViewController
            destinationVC.dataSource = dataSource
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .ScaleAspectFit
        let image = UIImage(named: "LeftLogoNavBar.png")
        imageView.image = image
        navigationItem.titleView = imageView
        navigationItem.title = "Left"
        
        let backgroundImage = UIImageView(frame: UIScreen.mainScreen().bounds)
        backgroundImage.image = UIImage(named: "kitchen")
        backgroundImage.alpha = 0.3
        self.view.insertSubview(backgroundImage, atIndex: 0)
        
        // Set up activity indicator
        hud.labelText = "Loading..."
        hud.labelFont = UIFont(name: "HelveticaNeue-Light", size: 15.0)!
        //hud.color = UIColor(red: 153.0/255.0, green: 51.0/255.0, blue:255.0/255.0, alpha: 1.0)
        hud.labelColor = UIColor(red: 153.0/255.0, green: 51.0/255.0, blue:255.0/255.0, alpha: 1.0)
        hud.activityIndicatorColor = UIColor(red: 153.0/255.0, green: 51.0/255.0, blue:255.0/255.0, alpha: 1.0)
        hud.color = UIColor.whiteColor()
        hud.opacity = 0.2
        self.view.addSubview(hud)
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.DismissKeyboard))
        view.addGestureRecognizer(tap)
        view.backgroundColor = bgColor
        ingredient1.delegate = self
        ingredient2.delegate = self
        ingredient3.delegate = self
        ingredient4.delegate = self
        ingredient5.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        ingredient1.resignFirstResponder()
        ingredient2.resignFirstResponder()
        ingredient3.resignFirstResponder()
        ingredient4.resignFirstResponder()
        ingredient5.resignFirstResponder()
        return true;
    }
    
    func showAlert(alertType: String) {
        switch alertType {
        case "moreThanFiveIngredients":
            let alert = UIAlertController(title: "Oops!", message: "You cannot use more than 5 ingredients", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Got it", style: .Default) { _ in }
            alert.addAction(action)
            self.presentViewController(alert, animated: true) {}
            
        case "noResults":
            let alert = UIAlertController(title: "😢", message: "No results found...", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Ok", style: .Default) { _ in }
            alert.addAction(action)
            self.presentViewController(alert, animated: true) {}
            
        case "searchFailure":
            let alert = UIAlertController(title: "Something went wrong", message: "Are you sure you are connected to the Internet? 🔌🌎", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Ok", style: .Default) { _ in }
            alert.addAction(action)
            self.presentViewController(alert, animated: true) {}
        case "atLeastOneIngredient":
            let alert = UIAlertController(title: "Hey", message: "Please provide at least one ingredient!", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Ok", style: .Default) { _ in }
            alert.addAction(action)
            self.presentViewController(alert, animated: true) {}
            
        default:
            break
        }
    }
}

//        Alamofire.request(.GET, urlWithIngredients).validate().responseJSON { response in
//            switch response.result {
//            case .Success:
//                if let value = response.result.value {
//                    var res = JSON(value)
//                    print(Int(String(res["count"]))!)
//                    let count = Int(String(res["count"]))!
//                    if count > 0 {
//                        for i in 0...count - 1 {
//                            if let name = res["recipes"][i]["title"].string {
//                                let url: String = res["recipes"][i]["source_url"].string!
//                                let photo: UIImage? = res["recipes"][i]["image_url"].string!.urlToImg()
//                                let curr: RecipeItem = RecipeItem(name: name, photo: photo, url: url)
//                                self.dataSource.recipes.append(curr)
//                            }
//                        }
//                    }
//                    if (count > 0) {
//                        self.performSegueWithIdentifier("resultsSegue", sender: self)
//                    } else {
//                        self.showAlert("noResults")
//                    }
//                }
//            case .Failure(let error):
//                self.showAlert("searchFailure")
//                print(error)
//            }
//        }

// MARK: - Edamam API Request Handling
//        Alamofire.request(.GET, urlWithIngredients).validate().responseJSON { response in
//            switch response.result {
//            case .Success:
//                if let value = response.result.value {
//                    var res = JSON(value)
//                    print(Int(String(res["count"]))!)
//                    let count = Int(String(res["count"]))!
//                    // checking because edamam plan gives at most 100 results (but count might be > 100)
//                    if count > 0 && count < 100 {
//                        for i in 0...count - 1 {
//                            if let name = res["hits"][i]["recipe"]["label"].string {
//                                let url: String = res["hits"][i]["recipe"]["url"].string!
//                                let photo: UIImage? = res["hits"][i]["recipe"]["image"].string!.urlToImg()
//                                let curr: RecipeItem = RecipeItem(name: name, photo: photo, url: url)
//                                self.data.append(curr)
//                            }
//                        }
//                    } else {
//                        for i in 0...99 {
//                            if let name = res["hits"][i]["recipe"]["label"].string {
//                                let url: String = res["hits"][i]["recipe"]["url"].string!
//                                let photo: UIImage? = res["hits"][i]["recipe"]["image"].string!.urlToImg()
//                                let curr: RecipeItem = RecipeItem(name: name, photo: photo, url: url)
//                                self.data.append(curr)
//                            }
//                        }
//                    }
//                    if (count > 0) {
//                        self.performSegueWithIdentifier("resultsSegue", sender: self)
//                    } else {
//                        self.showAlert("noResults")
//                    }
//                }
//            case .Failure(let error):
//                self.showAlert("searchFailure")
//                print(error)
//            }
//        }
