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
        webView.delegate = self
        activityIndicator.hidden = true
        self.navigationItem.title = recipe?.name
        loadWeb()
    }
    
    func loadWeb() {
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
    
    func showActivityViewController() {
        let activityViewController = UIActivityViewController(activityItems: ["I found this recipe on Left app ", (recipe?.url)!], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: {})
    }
}
