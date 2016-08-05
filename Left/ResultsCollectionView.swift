//
//  RecipeCollection.swift
//  Left
//
//  Created by Alejandrina Patron on 7/22/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import Foundation
import UIKit

class ResultsCollectionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let favoritesManager = FavoritesManager.sharedInstance
    
    private var recipes = [RecipeItem]()
    lazy var searchBar = UISearchBar()
    
    private var loaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        UIApplication.sharedApplication().statusBarStyle = .LightContent
//        let view = UIView(frame:
//            CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: 20.0)
//        )
//        view.backgroundColor = UIColor.LeftColor()
//        self.view.addSubview(view)
//        
//        navigationController?.hidesBarsOnSwipe = true
//        
        
        searchBar.sizeToFit()
        searchBar.tintColor = UIColor.whiteColor()
        searchBar.backgroundColor = UIColor.clearColor()
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search with comma separated ingredients"
        searchBar.subviews[0].subviews.flatMap(){ $0 as? UITextField }.first?.tintColor = UIColor.LeftColor()
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        loadRecipes()
    }
    
    // MARK: Collection View Delegate
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RecipeCell", forIndexPath: indexPath) as! RecipeCollectionCell
        
        let recipe = recipes[indexPath.row]
        cell.recipe = recipe
        
        // Handle delete button action
        cell.favoriteButton.layer.setValue(indexPath.row, forKey: "index")
        cell.favoriteButton.addTarget(self, action: #selector(ResultsCollectionView.saveRecipe(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//        cell.deleteButton.addTarget(self, action: #selector(FavoritesCollectionView.deleteRecipe), forControlEvents: UIControlEvents.TouchUpInside)
//        
//        // Handle label tap action
//        let labelTap = UITapGestureRecognizer(target: self, action: #selector(FavoritesCollectionView.openRecipeUrl))
//        labelTap.numberOfTapsRequired = 1
//        cell.recipeName.addGestureRecognizer(labelTap)
//        
//        // Handle photo tap action
//        let photoTap = UITapGestureRecognizer(target: self, action: #selector(FavoritesCollectionView.openRecipeUrl))
//        photoTap.numberOfTapsRequired = 1
//        cell.recipePhoto.addGestureRecognizer(photoTap)
        
        cell.contentView.layer.borderColor = UIColor.lightGrayColor().CGColor
        cell.contentView.layer.borderWidth = 0.6
        
        
        
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
    
    // MARK: Search Bar Delegate
    
    // MARK: Helper
    func openRecipeUrl(sender: UITapGestureRecognizer) {
        let cell = sender.view?.superview?.superview as! FavoriteRecipeCollectionCell
        let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RecipeWebView") as! RecipeWebView
        webView.url = cell.recipe.url
        webView.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: nil)
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
    func loadRecipes() {
        if (!loaded) {
            print("Loading!")
            Food2ForkService.recipesForIngredients("nutella,banana", completion: { [] recipes in
                self.recipes = recipes
                self.collectionView.reloadData()
            })
        }
        loaded = true
    }
    
    func saveRecipe(sender: UIButton) {
        let index: Int = (sender.layer.valueForKey("index")) as! Int
        let recipe = recipes[index]
        
//        let favoritesView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("FavoritesView") as! FavoritesCollectionView
        favoritesManager.addRecipe(recipe)
//        if favoritesView.isViewLoaded() {
//            favoritesView.collectionView.reloadData()
//        }
    }

}