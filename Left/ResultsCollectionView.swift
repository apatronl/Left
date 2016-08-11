//
//  RecipeCollection.swift
//  Left
//
//  Created by Alejandrina Patron on 7/22/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import Foundation
import UIKit
import Nuke

class ResultsCollectionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let favoritesManager = FavoritesManager.sharedInstance
    private var recipesLoader: RecipesLoader?
    private var recipes = [RecipeItem]()
    var ingredients = [String]()
    var addButton: UIBarButtonItem!
    var manager = Nuke.ImageManager.shared
    
    private var loaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add infinite scroll handler
        collectionView?.addInfiniteScrollWithHandler { [weak self] (scrollView) -> Void in
            if let loader = self?.recipesLoader {
                if loader.hasMoreRecipes() {
                    self?.loadMoreRecipes() {
                        scrollView.finishInfiniteScroll()
                    }
                } else {
                    print("No more recipes!")
                    scrollView.finishInfiniteScroll()
                }
            }
        }
        
        var ingredientsString = ""
        for ingredient in ingredients {
            ingredientsString += ingredient + ","
        }
        loadRecipes(ingredientsString)
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

        // Handle label tap action
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(ResultsCollectionView.openRecipeUrl))
        labelTap.numberOfTapsRequired = 1
        cell.recipeName.addGestureRecognizer(labelTap)
        
        // Handle photo tap action
        let photoTap = UITapGestureRecognizer(target: self, action: #selector(ResultsCollectionView.openRecipeUrl))
        photoTap.numberOfTapsRequired = 1
        cell.recipePhoto.addGestureRecognizer(photoTap)
        
        let imageView = cell.recipePhoto
        imageView.nk_setImageWith(NSURL(string: recipe.photoUrl!)!)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        var height = (UIScreen.mainScreen().bounds.width / 2) - 15
        if height > 250 {
            height = (UIScreen.mainScreen().bounds.width / 3) - 15
        }
        
        return CGSizeMake(height, height)
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let recipeCell = cell as! RecipeCollectionCell
        recipeCell.recipePhoto.nk_cancelLoading()
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
    
    // MARK: Helper
    
    func loadRecipes(ingredients: String) {
        if (!loaded) {
            recipesLoader = RecipesLoader(ingredients: ingredients)
            recipesLoader!.load(completion: { recipes, error in
                if let error = error {
                    self.showAlert(.SearchFailure)
                    self.navigationItem.title = "Error"
                    print("Error! " + error.localizedDescription)
                } else if (recipes.count == 0) {
                    self.showAlert(.NoResults)
                    self.recipesLoader!.setHasMore(false)
                    self.navigationItem.title = "No Results"
                } else {
                    // Food2Fork returns at most 30 recipes on each page
                    if (recipes.count < 30) {
                        self.recipesLoader!.setHasMore(false)
                    }
                    self.recipes = recipes
                    self.collectionView.reloadData()
                    self.navigationItem.title = "Results"
                }
            })
        }
        loaded = true
    }
    
    private func loadMoreRecipes(handler: (Void -> Void)?) {
        if let loader = recipesLoader {
            loader.loadMore({ recipes, error in
                if let error = error {
                    self.handleResponse(nil, error: error, completion: handler)
                } else {
                    self.handleResponse(recipes, error: nil, completion: handler)
                }
            })
        }
    }
    
    // Handle response when loading more recipes with infinite scroll
    private func handleResponse(data: [RecipeItem]?, error: NSError?, completion: (Void -> Void)?) {
        if let _ = error {
            completion?()
            return
        }
        
        if (data!.count == 0) {
            self.recipesLoader?.setHasMore(false)
            completion?()
            return
        }
        
        // Food2Fork returns at most 30 recipes on each page
        if (data!.count < 30) {
            self.recipesLoader?.setHasMore(false)
        }
        
        var indexPaths = [NSIndexPath]()
        let firstIndex = recipes.count
        
        for (i, recipe) in data!.enumerate() {
            let indexPath = NSIndexPath(forItem: firstIndex + i, inSection: 0)
            recipes.append(recipe)
            indexPaths.append(indexPath)
        }
        
        collectionView?.performBatchUpdates({ () -> Void in
            self.collectionView?.insertItemsAtIndexPaths(indexPaths)
            }, completion: { (finished) -> Void in
                completion?()
        });
    }
    
    func saveRecipe(sender: UIButton) {
        let index: Int = (sender.layer.valueForKey("index")) as! Int
        let recipe = recipes[index]
        favoritesManager.addRecipe(recipe)
    }
    
    func openRecipeUrl(sender: UITapGestureRecognizer) {
        let cell = sender.view?.superview?.superview as! RecipeCollectionCell
        let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("RecipeWebView") as! RecipeWebView
        webView.url = cell.recipe.url
        webView.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: nil)
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
    // MARK: UI
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
}