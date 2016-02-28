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

class SearchViewController: UIViewController {

    @IBOutlet weak var ingredient1: UITextField!
    @IBOutlet weak var ingredient2: UITextField!
    @IBOutlet weak var ingredient3: UITextField!
    @IBOutlet weak var ingredient4: UITextField!
    @IBOutlet weak var ingredient5: UITextField!
    
    var ingredients = [String]()
    let url: String = "http://food2fork.com/api/search?key=570024717057c65d605c4d54f84f2300&q="
    let apiKey: String = "570024717057c65d605c4d54f84f2300"
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
//        if (ingredient2.hidden == false) {
//            if let ing2 = ingredient2.text {
//                ingredients.append(ing2)
//            }
//        }
//        if (ingredient3.hidden == true) {
//            if let ing3 = ingredient3.text {
//                ingredients.append(ing3)
//            }
//        }
//        if (ingredient4.hidden == true) {
//            if let ing4 = ingredient4.text {
//                ingredients.append(ing4)
//            }
//        }
//        if (ingredient5.hidden == true) {
//            if let ing5 = ingredient5.text {
//                ingredients.append(ing5)
//            }
//        }
        let length: Int = ingredients.count
        var urlWithIngredients: String = "http://food2fork.com/api/search?key=570024717057c65d605c4d54f84f2300&q="
        for i in 0...length - 1 {
            if (i == 0) {
                urlWithIngredients += ingredients.first!
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
//                    self.activityIndicator.hidden = false
//                    self.activityIndicator.startAnimating()
                    if count > 0 {
                        for i in 0...count - 1 {
                            let name: String = res["recipes"][i]["title"].string!
                            let url: String = res["recipes"][i]["source_url"].string!
                            let photo: UIImage? = res["recipes"][i]["image_url"].string!.urlToImg()
                            let curr: RecipeItem = RecipeItem(name: name, photo: photo, url: url)
                            self.data.append(curr)
                        }
                    }
                }
//                self.activityIndicator.stopAnimating()
                self.performSegueWithIdentifier("resultsSegue", sender: self)
            case .Failure(let error):
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
        
        let image = UIImage(named: "leftLogo.png")
        navigationItem.titleView = UIImageView(image: image)

        navigationItem.title = "Left"
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        view.backgroundColor = bgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func DismissKeyboard(){
        view.endEditing(true)
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

