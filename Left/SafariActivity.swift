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
    
    override var activityType: UIActivityType? {
        return UIActivityType(rawValue: NSStringFromClass(SafariActivity.self))
    }
    
    override var activityTitle: String? {
        return "Open in Safari"
    }
    
    override var activityImage: UIImage? {
        return UIImage(named: "safari-activity")
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        for item in activityItems {
            if let item = item as? NSURL {
                URL = item
            }
        }
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        for item in activityItems {
            if let _ = item as? NSURL {
                return true
            }
        }
        return false
    }
    
    override func perform() {
        if let URL = URL {
            UIApplication.shared.openURL(URL as URL)
        }
    }
    
}
