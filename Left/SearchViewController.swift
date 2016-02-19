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

//    var ingredients = [NSString]()
    let apiKey: String = "570024717057c65d605c4d54f84f2300"
    let rq: RequestHandler = RequestHandler()
    var data = [RecipeItem]()
    
    @IBOutlet weak var ingredient1: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func resignKeyboard(sender: AnyObject) {
        sender.resignFirstResponder()
    }

    @IBAction func searchButtonPressed(sender: UIButton) {
        
        Alamofire.request(.GET, "http://food2fork.com/api/search?key=570024717057c65d605c4d54f84f2300&q=chocolate").validate().responseJSON { response in
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
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "leftLogo.png")
        navigationItem.titleView = UIImageView(image: image)

        navigationItem.title = "Left"
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
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

