//
//  RecipeWebView.swift
//  Left
//
//  Created by Alejandrina Patron on 8/4/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit

class RecipeWebView: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    
    var url: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openUrl()
    }
    
    func openUrl() {
        let url = NSURL(string: (self.url))
        let requesObj = NSURLRequest(URL: url!)
        webView.loadRequest(requesObj)
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
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
//        activityIndicator.hidden = false
//        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
//        activityIndicator.hidden = true
//        activityIndicator.stopAnimating()
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
        activityViewController.view.tintColor = UIColor.LeftColor()
        presentViewController(activityViewController, animated: true, completion: {})
    }
    
}


