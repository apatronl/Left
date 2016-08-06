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
}


