//
//  NavViewController.swift
//  Left
//
//  Created by Alejandrina Patron on 9/21/15.
//  Copyright © 2015 Ale Patrón. All rights reserved.
//

import UIKit
import Toast_Swift

class NavViewController: UINavigationController {
    
    let toastColor: UIColor = UIColor(red: 153.0/255.0, green: 51.0/255.0, blue:255.0/255.0, alpha: 0.8)

    override func viewDidLoad() {
        UINavigationBar.appearance().barTintColor = UIColor.LeftColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        
        
        var style = ToastStyle()
        style.messageFont = UIFont(name: "HelveticaNeue-Thin", size: 15.0)!
        style.messageColor = UIColor.whiteColor()
        style.messageAlignment = .Center
        style.backgroundColor = self.toastColor
        
        ToastManager.shared.style = style
        
        //UITabBar.appearance().backgroundColor = myNavBarColor
        UITabBar.appearance().tintColor = UIColor.LeftColor()
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func  preferredStatusBarStyle()-> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
