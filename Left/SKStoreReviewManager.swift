//
//  SKStoreReviewManager.swift
//  Left
//
//  Created by Alejandrina Patron on 5/14/17.
//  Copyright © 2017 Ale Patrón. All rights reserved.
//

import StoreKit

struct SKStoreReviewManager {
    
    private static let APP_RUNS_KEY = "APP_RUNS"
    
    // Call this function in AppDelegate.swift on app launch
    static func incrementAppRuns() {
        let defaults = UserDefaults.standard
        var appRuns = defaults.value(forKey: APP_RUNS_KEY) as? Int ?? 0
        appRuns += 1
        print(appRuns)
        defaults.set(appRuns, forKey: APP_RUNS_KEY)
    }
    
    static func askForReview() {
        let defaults = UserDefaults.standard
        let appRuns = defaults.value(forKey: APP_RUNS_KEY) as? Int ?? 0
        
        if #available(iOS 10.3, *) {
            if appRuns > 0 && appRuns % 15 == 0 {
                SKStoreReviewController.requestReview()
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
}
