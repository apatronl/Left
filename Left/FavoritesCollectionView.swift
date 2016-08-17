//
//  FavoritesCollectionView.swift
//  Left
//
//  Created by Alejandrina Patron on 8/3/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import Foundation

class FavoritesCollectionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    let favoritesManager = FavoritesManager.sharedInstance
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    // MARK: - Collection View Delegate
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesManager.recipeCount()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecipeCell", forIndexPath: indexPath) as! FavoriteRecipeCollectionCell
        
        let recipe = favoritesManager.recipeAtIndex(indexPath.row)
        cell.recipe = recipe
        
        // Handle delete button action
        cell.deleteButton?.layer.setValue(indexPath.row, forKey: "index")
        cell.deleteButton.addTarget(self, action: #selector(FavoritesCollectionView.deleteRecipe), forControlEvents: UIControlEvents.TouchUpInside)
        
        // Handle label tap action
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(FavoritesCollectionView.openRecipeUrl))
        labelTap.numberOfTapsRequired = 1
        cell.recipeName.addGestureRecognizer(labelTap)
        
        // Handle photo tap action
        let photoTap = UITapGestureRecognizer(target: self, action: #selector(FavoritesCollectionView.openRecipeUrl))
        photoTap.numberOfTapsRequired = 1
        cell.recipePhoto.addGestureRecognizer(photoTap)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var height = (UIScreen.mainScreen().bounds.width / 2) - 15
        if height > 250 {
            height = (UIScreen.mainScreen().bounds.width / 3) - 15
        }
        return CGSizeMake(height, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    // MARK: - Helper
    
    func deleteRecipe(sender: UIButton) {
        let index: Int = (sender.layer.valueForKey("index")) as! Int
        favoritesManager.deleteRecipeAtIndex(index)
        collectionView.reloadData()
    }
    
    func openRecipeUrl(sender: UITapGestureRecognizer) {
        let cell = sender.view?.superview?.superview as! FavoriteRecipeCollectionCell
        let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RecipeWebView") as! RecipeWebView
        webView.recipe = cell.recipe
        webView.navigationItem.title = cell.recipe.name
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
}