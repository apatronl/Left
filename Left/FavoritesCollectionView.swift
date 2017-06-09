//
//  FavoritesCollectionView.swift
//  Left
//
//  Created by Alejandrina Patron on 8/3/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import Foundation
import SwiftyDrop

class FavoritesCollectionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIViewControllerPreviewingDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    let favoritesManager = FavoritesManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (traitCollection.forceTouchCapability == .available) {
            registerForPreviewing(with: self, sourceView: view)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesManager.recipeCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath as IndexPath) as! LFTRecipeCollectionCell
        
        let recipe = favoritesManager.recipeAtIndex(index: indexPath.row)
        cell.recipe = recipe
        
        // Handle delete button action
        cell.actionButton?.layer.setValue(indexPath.row, forKey: "index")
        cell.actionButton.addTarget(self, action: #selector(FavoritesCollectionView.deleteRecipe), for: UIControlEvents.touchUpInside)
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height = (UIScreen.main.bounds.width / 2) - 15
        if height > 250 {
            height = (UIScreen.main.bounds.width / 3) - 15
        }
        return CGSize(width: height, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    // MARK: UIViewControllerPreviewingDelegate
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = collectionView.indexPathForItem(at: location) else { return nil }
        guard let cell = collectionView.cellForItem(at: indexPath) as? LFTRecipeCollectionCell else { return nil }
        //if let _ = cell.deleteButton.hitTest(location, with: nil) { return nil }
        if cell.actionButton.point(inside: location, with: nil) { return nil }
        guard let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecipeWebView") as? RecipeWebView else { return nil }
        webView.recipe = cell.recipe
        webView.preferredContentSize = CGSize(width: 0.0, height: 500)
        previewingContext.sourceRect = cell.frame
        
        return webView
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
    }
    
    // MARK: Helper
    
    func deleteRecipe(sender: UIButton) {
        let index: Int = (sender.layer.value(forKey: "index")) as! Int
        
        if let recipe = favoritesManager.recipeAtIndex(index: index) {
            recipe.removeFromDefaults(index: index)
        }
        
        favoritesManager.deleteRecipeAtIndex(index: index)
        collectionView.reloadData()
        Drop.down("Recipe removed from your favorites", state: Custom.Left)
        
        // Haptic feedback (available iOS 10+)
        if #available(iOS 10.0, *) {
            let savedRecipeFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
            savedRecipeFeedbackGenerator.impactOccurred()
        }

    }
    
    func openRecipeUrl(sender: UITapGestureRecognizer) {
        let cell = sender.view?.superview?.superview as! LFTRecipeCollectionCell
        let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecipeWebView") as! RecipeWebView
        webView.recipe = cell.recipe
        
        // Update open count of recipe for 3D touch quick actions
        cell.recipe.updateOpenCount()
        
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
}
