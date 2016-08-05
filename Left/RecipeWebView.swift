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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let view = UIView(frame:
            CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: 20.0)
        )
        view.backgroundColor = UIColor.LeftColor()
        self.view.addSubview(view)
        
        navigationController?.hidesBarsOnSwipe = true
    }
    
    func openUrl() {
        let url = NSURL(string: (self.url))
        let requesObj = NSURLRequest(URL: url!)
        webView.loadRequest(requesObj)
    }
}


