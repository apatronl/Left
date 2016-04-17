//
//  FavoriteRecipeViewController.swift
//  Left
//
//  Created by Alejandrina Patron on 3/8/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit

class FavoriteRecipeViewController: UIViewController, UIWebViewDelegate {
    
    var recipe: RecipeItem?
    
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tabBarController?.tabBar.hidden = true
        webView.delegate = self
        activityIndicator.hidden = true
        self.navigationItem.title = recipe?.name
        loadRecipe()
    }
    
    func loadRecipe() {
        let url = NSURL(string: (recipe?.url)!)
        let requesObj = NSURLRequest(URL: url!)
        webView.loadRequest(requesObj)
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
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true  
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
