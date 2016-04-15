//
//  SafariActivity.swift
//  
//
//  Created by Alejandrina Patron on 4/14/16.
//
//

import UIKit

class SafariActivity : UIActivity {
    
    var URL: NSURL?
    
    override func activityType() -> String? {
        return NSStringFromClass(SafariActivity)
    }
    
    override func activityTitle() -> String? {
        return "Open in Safari"
    }
    
    override func activityImage() -> UIImage? {
        return UIImage(named: "safari-activity")
    }
    
    override func prepareWithActivityItems(activityItems: [AnyObject]) {
        for item in activityItems {
            if let item = item as? NSURL {
                URL = item
            }
        }
    }
    
    override func canPerformWithActivityItems(activityItems: [AnyObject]) -> Bool {
        for item in activityItems {
            if let _ = item as? NSURL {
                return true
            }
        }
        return false
    }
    
    override func performActivity() {
        if let URL = URL {
            UIApplication.sharedApplication().openURL(URL)
        }
    }
    
}
