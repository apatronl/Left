//
//  SearchTableView+Keyboard.swift
//  Left
//
//  Created by Alejandrina Patron on 1/25/17.
//  Copyright © 2017 Ale Patrón. All rights reserved.
//

import UIKit

extension SearchTableView {
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(SearchTableView.keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SearchTableView.keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
//            if (self.view.frame.origin.y >= 0) {
//                view.frame.origin.y -= (keyboardHeight - (self.tabBarController?.tabBar.frame.size.height)!)
//            }
            self.searchButton.frame.origin.y -= (keyboardHeight - (self.tabBarController?.tabBar.frame.size.height)!)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
//            if (self.view.frame.origin.y < 0) {
//                view.frame.origin.y += (keyboardHeight - (self.tabBarController?.tabBar.frame.size.height)!)
//            }
            self.searchButton.frame.origin.y += (keyboardHeight - (self.tabBarController?.tabBar.frame.size.height)!)
        }
    }

}
