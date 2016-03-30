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
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidden = true
        self.navigationItem.title = recipe?.name
        favoriteVC = (self.tabBarController?.viewControllers![1] as! NavViewController).viewControllers[0] as? FavoritesViewController
        loadWeb()
    }
    
    func loadWeb() {
        let url = NSURL(string: (recipe?.url)!)
        let requestObj = NSURLRequest(URL: url!)
        webView.loadRequest(requestObj)
    }
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        favoriteVC?.favoritesManager.favoriteRecipes.append(recipe!)
        favoriteVC?.tableView.reloadData()
        favoriteVC?.favoritesManager.save()
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func forward(sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        }
    }
    
    @IBAction func reload(sender: UIBarButtonItem) {
        webView.reload()
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.hidden = true
        activityIndicator.stopAnimating()
        if (webView.canGoBack) {
            backButton.enabled = true
        } else {
            backButton.enabled = false
        }
        if (webView.canGoForward) {
            forwardButton.enabled = true
        } else {
            forwardButton.enabled = false
        }
    }
    
    func animateActivityIndicator(on on: Bool) {
        
        var originalIndicatorPosition: CGPoint {
            return CGPointMake(webView.center.x, webView.center.y)
        }
        
        if on {
            let originalPosition = originalIndicatorPosition
            let animationStart = CGPointMake(originalPosition.x, originalPosition.y)
            activityIndicator.frame.origin = animationStart
            UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
                self.activityIndicator.frame.origin = originalPosition
                self.activityIndicator.alpha = 1.0
                }, completion: nil)
        }
        else {
            let originalPosition = originalIndicatorPosition
            let animationEnd = CGPointMake(originalPosition.x, originalPosition.y + 50)
            UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: [], animations: {
                self.activityIndicator.frame.origin = animationEnd
                self.activityIndicator.alpha = 0.0
                }, completion: nil)
        }
    }
}
