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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let favoritesManager = FavoritesManager.shared
    var recipe: RecipeItem!
    var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NOTE: saveButton visible when coming from Results but not from Favorites
        if let saveButton = self.navigationItem.rightBarButtonItem {
            saveButton.target = self
            saveButton.action = #selector(RecipeWebView.saveButtonPressed(sender:))
        }
        
        self.navigationItem.title = recipe.name
        activityIndicator.hidesWhenStopped = true
        openUrl()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.tabBarController?.tabBar.isHidden = true
//    }
    
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
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
        updateNavButtons()
    }
    
    // MARK: Helper
    
    func openUrl() {
        let url = NSURL(string: (self.recipe.url))
        let requesObj = NSURLRequest(url: url! as URL)
        webView.loadRequest(requesObj as URLRequest)
    }
    
    func updateNavButtons() {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
    }
    
    func saveButtonPressed(sender: UIBarButtonItem!) {
        favoritesManager.addRecipe(recipe: self.recipe)
        Drop.down("Added to your favorites ⭐", state: Custom.Left)
        
        // Haptic feedback (available iOS 10+)
        if #available(iOS 10.0, *) {
            let savedRecipeFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
            savedRecipeFeedbackGenerator.impactOccurred()
        }
    }
    
    // MARK: Safari Activity
    
    func showActivityViewController() {
        let activityItems: [AnyObject] =
            ["I found this recipe on Left app " as AnyObject, NSURL(string: self.recipe.url) as AnyObject]
        let activities: [UIActivity] = [SafariActivity()]
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: activities)
        activityViewController.view.tintColor = UIColor.LeftColor()
        present(activityViewController, animated: true, completion: {})
    }
    
}
