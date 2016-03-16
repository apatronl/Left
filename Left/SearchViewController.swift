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

    @IBOutlet weak var ingredient1: UITextField!
    @IBOutlet weak var ingredient2: UITextField!
    @IBOutlet weak var ingredient3: UITextField!
    @IBOutlet weak var ingredient4: UITextField!
    @IBOutlet weak var ingredient5: UITextField!
    
    
    //    food2fork.com not working
    //    static let apiKey: String = "570024717057c65d605c4d54f84f2300"
    //    let url: String = "http://food2fork.com/api/search?key=" + apiKey + "&q="
    
    var ingredients = [String]()
    
    //    switched to edamam.com
    static let appKey: String = "f4b2d1504f9002b21dc8da278d093cf3"
    static let appID: String = "82104c57"
    let url: String = "https://api.edamam.com/search?app_id=" + appID + "&app_key=" + appKey + "&from=0&to=100&q="
    let rq: RequestHandler = RequestHandler()
    var data = [RecipeItem]()
    let bgColor: UIColor = UIColor(red: 245.0/255.0, green: 245.0/255.0, blue:245.0/255.0, alpha: 1.0)
    var numOfIngredients: Int = 1
    
    @IBAction func add(sender: UIButton) {
        if (numOfIngredients <= 5) {
            numOfIngredients++
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
            let alert = UIAlertController(title: "Oops!", message: "You cannot use more than 5 ingredients", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Got it", style: .Default) { _ in }
            alert.addAction(action)
            self.presentViewController(alert, animated: true) {}
        }
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func resignKeyboard(sender: AnyObject) {
        sender.resignFirstResponder()
    }

    @IBAction func searchButtonPressed(sender: UIButton) {
        if let ing1 = ingredient1.text {
            ingredients.append(ing1)
        }
        if (ingredient2.hidden == false) {
            if let ing2 = ingredient2.text {
                if (ing2 != "") {
                    ingredients.append(ing2)
                }
            }
        }
        if (ingredient3.hidden == false) {
            if let ing3 = ingredient3.text {
                if (ing3 != "") {
                    ingredients.append(ing3)
                }
            }
        }
        if (ingredient4.hidden == false) {
            if let ing4 = ingredient4.text {
                if (ing4 != "") {
                    ingredients.append(ing4)
                }
            }
        }
        if (ingredient5.hidden == false) {
            if let ing5 = ingredient5.text {
                if (ing5 != "") {
                    ingredients.append(ing5)
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
        
        Alamofire.request(.GET, urlWithIngredients).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    var res = JSON(value)
                    print(Int(String(res["count"]))!)
                    let count = Int(String(res["count"]))!
                    // checking because edamam plan gives at most 100 results (but count might be > 100)
                    if count > 0 && count < 100 {
                        for i in 0...count - 1 {
                            if let name = res["hits"][i]["recipe"]["label"].string {
                                let url: String = res["hits"][i]["recipe"]["url"].string!
                                let photo: UIImage? = res["hits"][i]["recipe"]["image"].string!.urlToImg()
                                let curr: RecipeItem = RecipeItem(name: name, photo: photo, url: url)
                                self.data.append(curr)
                            }
                        }
                    } else {
                        for i in 0...99 {
                            if let name = res["hits"][i]["recipe"]["label"].string {
                                let url: String = res["hits"][i]["recipe"]["url"].string!
                                let photo: UIImage? = res["hits"][i]["recipe"]["image"].string!.urlToImg()
                                let curr: RecipeItem = RecipeItem(name: name, photo: photo, url: url)
                                self.data.append(curr)
                            }
                        }
                    }
                }
                self.performSegueWithIdentifier("resultsSegue", sender: self)
            case .Failure(let error):
                let alert = UIAlertController(title: "Oops!", message: "Connection failed. Make sure you are connected to the internet.", preferredStyle: .Alert)
                let action = UIAlertAction(title: "Ok", style: .Default) { _ in }
                alert.addAction(action)
                self.presentViewController(alert, animated: true) {}
                print(error)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "resultsSegue" {
            let destinationVC = segue.destinationViewController as! ResultsViewController
            destinationVC.data = data
        }
        data.removeAll()
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .ScaleAspectFit
        let image = UIImage(named: "LeftLogoNavBar.png")
        imageView.image = image
        navigationItem.titleView = imageView
        navigationItem.title = "Left"
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
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

