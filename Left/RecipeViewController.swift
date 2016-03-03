//
//  RecipeViewController.swift
//  Left
//
//  Created by Alejandrina Patron on 9/24/15.
//  Copyright © 2015 Ale Patrón. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UIWebViewDelegate {
    
    var recipe: RecipeItem?
    var recipeName: String?
    var recipeURL: String?
    var delegate: UpdateFavorites?
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidden = true
        self.navigationItem.title = recipe?.name
    
        let url = NSURL(string: (recipe?.url)!)
        let requestObj = NSURLRequest(URL: url!)
        webView.loadRequest(requestObj)
    }
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        print(recipe!.name)
        delegate?.passBackRecipe(recipe!)
        print(delegate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.hidden = true
        activityIndicator.stopAnimating()
    }
}

protocol UpdateFavorites {
    func passBackRecipe(recipe: RecipeItem)
}
