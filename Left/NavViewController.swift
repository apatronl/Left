//
//  NavViewController.swift
//  Left
//
//  Created by Alejandrina Patron on 9/21/15.
//  Copyright © 2015 Ale Patrón. All rights reserved.
//

import UIKit

class NavViewController: UINavigationController {
    
    override func viewDidLoad() {
        UINavigationBar.appearance().barTintColor = UIColor.LeftColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
        
        //UITabBar.appearance().backgroundColor = myNavBarColor
        UITabBar.appearance().tintColor = UIColor.LeftColor()
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
//    override func  preferredStatusBarStyle()-> UIStatusBarStyle {
//        return UIStatusBarStyle.lightContent
//    }
    
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
