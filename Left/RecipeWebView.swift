//
//  RecipeWebView.swift
//  Left
//
//  Created by Alejandrina Patron on 8/4/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit
import SwiftyDrop

class RecipeWebView: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    private let favoritesManager = FavoritesManager.sharedInstance
    let hud = MBProgressHUD()
    var recipe: RecipeItem!
    var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NOTE: saveButton visible when coming from Results but not from Favorites
        if let saveButton = self.navigationItem.rightBarButtonItem {
            saveButton.target = self
            saveButton.action = #selector(RecipeWebView.saveButtonPressed(_:))
        }
        
        // Add activity indicator
        self.view.addSubview(hud)
        openUrl()
    }
    
    @IBAction func refresh(sender: UIBarButtonItem) {
        webView.reload()
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
    
    @IBAction func action(sender: UIBarButtonItem) {
        showActivityViewController()
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        hud.show(true)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        hud.hide(true)
        updateNavButtons()
    }
    
    // MARK: Helper
    
    func openUrl() {
        let url = NSURL(string: (self.recipe.url))
        let requesObj = NSURLRequest(URL: url!)
        webView.loadRequest(requesObj)
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
    
    func saveButtonPressed(sender: UIBarButtonItem!) {
        favoritesManager.addRecipe(self.recipe)
        Drop.down("Added to your favorites ⭐", state: Custom.Left)
    }
    
    // MARK: Safari Activity
    
    func showActivityViewController() {
        var activityItems: [AnyObject] = ["I found this recipe on Left app "]
        var activities: [UIActivity] = []
        if let url = webView.request?.URL {
            activityItems.append(url)
            activities.append(SafariActivity())
        }
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: activities)
        activityViewController.view.tintColor = UIColor.LeftColor()
        presentViewController(activityViewController, animated: true, completion: {})
    }
    
}