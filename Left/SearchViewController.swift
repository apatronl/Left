//
//  SearchViewController.swift
//  Left
//
//  Created by Alejandrina Patron on 9/18/15.
//  Copyright © 2015 A(pps)PL. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var ingredients = [NSString]()
    var recipes = [NSString]()
    
    @IBAction func resignKeyboard(sender: AnyObject) {
        sender.resignFirstResponder()
    }

//    @IBAction func searchButtonPressed(sender: UIButton) {
//        RestClient.getRecipes(["chocolate"])
//        
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let image = UIImage(named: "food.png")
//        navigationItem.titleView = UIImageView(image: image)

        navigationItem.title = "Left"
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

