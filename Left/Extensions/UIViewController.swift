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
            let alert = UIAlertController(title: "Oops!", message: "You cannot use more than 5 ingredients", preferredStyle: .alert)
            let action = UIAlertAction(title: "Got it", style: .default) { _ in }
            alert.addAction(action)
            self.present(alert, animated: true) {}
            
        case .NoResults:
            let alert = UIAlertController(title: "😢", message: "No results found...", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { _ in }
            alert.addAction(action)
            self.present(alert, animated: true) {}
            
        case .SearchFailure:
            let alert = UIAlertController(title: "Something went wrong", message: "Are you sure you are connected to the Internet? 🔌🌎", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { _ in }
            alert.addAction(action)
            self.present(alert, animated: true) {}
            
        case .AtLeastOneIngredient:
            let alert = UIAlertController(title: "Hey", message: "Please provide at least one ingredient!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { _ in }
            alert.addAction(action)
            self.present(alert, animated: true) {}
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
        case .Left: return .white
        }
    }
    var blurEffect: UIBlurEffect? {
        switch self {
        case .Left: return nil
        }
    }
}
