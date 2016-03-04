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
    var favoriteVC: FavoritesViewController?
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidden = true
        self.navigationItem.title = recipe?.name
        favoriteVC = (self.tabBarController?.viewControllers![1] as! NavViewController).viewControllers[0] as? FavoritesViewController
        
        let url = NSURL(string: (recipe?.url)!)
        let requestObj = NSURLRequest(URL: url!)
        webView.loadRequest(requestObj)
    }
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        favoriteVC?.favorites.append(recipe!)
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
