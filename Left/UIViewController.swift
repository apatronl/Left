//
//  UIViewController.swift
//  Left
//
//  Created by Alejandrina Patron on 8/4/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import SwiftyDrop

extension UIViewController {
    
    func showAlert(alertType: AlertType) {
        switch alertType {
        case .MoreThanFiveIngredients:
            let alert = UIAlertController(title: "Oops!", message: "You cannot use more than 5 ingredients", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Got it", style: .Default) { _ in }
            alert.addAction(action)
            self.presentViewController(alert, animated: true) {}
            
        case .NoResults:
            let alert = UIAlertController(title: "😢", message: "No results found...", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Ok", style: .Default) { _ in }
            alert.addAction(action)
            self.presentViewController(alert, animated: true) {}
            
        case .SearchFailure:
            let alert = UIAlertController(title: "Something went wrong", message: "Are you sure you are connected to the Internet? 🔌🌎", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Ok", style: .Default) { _ in }
            alert.addAction(action)
            self.presentViewController(alert, animated: true) {}
            
        case .AtLeastOneIngredient:
            let alert = UIAlertController(title: "Hey", message: "Please provide at least one ingredient!", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Ok", style: .Default) { _ in }
            alert.addAction(action)
            self.presentViewController(alert, animated: true) {}
        }
    }
}

// MARK: Alert Type

enum AlertType {
    case MoreThanFiveIngredients
    case NoResults
    case SearchFailure
    case AtLeastOneIngredient
}

// MARK: Custom SwiftyDrop

enum Custom: DropStatable {
    case Left
    var backgroundColor: UIColor? {
        switch self {
        case .Left: return UIColor.LeftColor()
        }
    }
    var font: UIFont? {
        switch self {
        case .Left: return UIFont(name: "HelveticaNeue", size: 16.0)
        }
    }
    var textColor: UIColor? {
        switch self {
        case .Left: return .whiteColor()
        }
    }
    var blurEffect: UIBlurEffect? {
        switch self {
        case .Left: return nil
        }
    }
}
