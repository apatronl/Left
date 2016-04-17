//
//  RecipeViewController.swift
//  Left
//
//  Created by Alejandrina Patron on 9/24/15.
//  Copyright © 2015 Ale Patrón. All rights reserved.
//

import UIKit
import Toast_Swift

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
        self.navigationItem.backBarButtonItem?.title = "Results"
        loadRecipe()
    }
    
    func loadRecipe() {
        let url = NSURL(string: (recipe?.url)!)
        let requestObj = NSURLRequest(URL: url!)
        webView.loadRequest(requestObj)
    }
    
    @IBAction func addButtonPressed(sender: UIBarButtonItem) {
        favoriteVC?.favoritesManager.favoriteRecipes.append(recipe!)
        favoriteVC?.tableView.reloadData()
        favoriteVC?.favoritesManager.save()
        self.navigationController?.view.makeToast("Added to favorites!", duration: 1.0, position: .Center, style: ToastManager.shared.style)
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
    
    @IBAction func activityButtonPressed(sender: UIBarButtonItem) {
        showActivityViewController()
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        activityIndicator.hidden = false
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        activityIndicator.hidden = true
        activityIndicator.stopAnimating()
        updateNavButtons()
    }
    
    func updateNavButtons() {
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
    
    func showActivityViewController() {
        var activityItems: [AnyObject] = ["I found this recipe on Left app "]
        var activities: [UIActivity] = []
        if let url = webView.request?.URL {
            activityItems.append(url)
            activities.append(SafariActivity())
        }
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: activities)
        activityViewController.view.tintColor = UIColor(red: 153.0/255.0, green: 51.0/255.0, blue:255.0/255.0, alpha: 1.0)
        presentViewController(activityViewController, animated: true, completion: {})
        
    }
}
