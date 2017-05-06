//
//  ResultsCollectionView.swift
//  Left
//
//  Created by Alejandrina Patron on 7/22/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import Foundation
import UIKit
import Nuke
import SwiftyDrop

class ResultsCollectionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let favoritesManager = FavoritesManager.sharedInstance
    private var recipesLoader: RecipesLoader?
    private var recipes = [RecipeItem]()
    var ingredients = [String]()
    var addButton: UIBarButtonItem!
    var manager = Nuke.Manager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add infinite scroll handler
        collectionView?.addInfiniteScroll { [weak self] (scrollView) -> Void in
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
        activityIndicator.hidesWhenStopped = true
        
        var ingredientsString = ""
        for ingredient in ingredients {
            ingredientsString += ingredient + ","
        }
        loadRecipes(ingredients: ingredientsString)
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        self.tabBarController?.tabBar.isHidden = false
//    }
    
    // MARK: Collection View Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath as IndexPath) as! RecipeCollectionCell
        
        let recipe = recipes[indexPath.row]
        cell.recipe = recipe
        
        // Handle delete button action
        cell.favoriteButton.layer.setValue(indexPath.row, forKey: "index")
        cell.favoriteButton.addTarget(self, action: #selector(ResultsCollectionView.saveRecipe(sender:)), for: UIControlEvents.touchUpInside)
        
        // Handle label tap action
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(ResultsCollectionView.openRecipeUrl))
        labelTap.numberOfTapsRequired = 1
        cell.recipeName.addGestureRecognizer(labelTap)
        
        // Handle photo tap action
        let photoTap = UITapGestureRecognizer(target: self, action: #selector(ResultsCollectionView.openRecipeUrl))
        photoTap.numberOfTapsRequired = 1
        cell.recipePhoto.addGestureRecognizer(photoTap)
        
        if recipe.photo == nil {
            recipe.photoUrl!.urlToImg(completion: { recipePhoto in
                if let photo = recipePhoto {
                    recipe.photo = photo
                } else {
                    recipe.photo = UIImage(named: "default")
                }
            })
            let imageView = cell.recipePhoto
            let request = Request(url: URL(string: recipe.photoUrl!)!)
            manager.loadImage(with: request, into: imageView!)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height = (UIScreen.main.bounds.width / 2) - 15
        if height > 250 {
            height = (UIScreen.main.bounds.width / 3) - 15
        }
        return CGSize(width: height, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let recipeCell = cell as! RecipeCollectionCell
        //recipeCell.recipePhoto.nk_cancelLoading()
        manager.cancelRequest(for: recipeCell.recipePhoto)
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
    
    // MARK: Helper
    
    func loadRecipes(ingredients: String) {
        activityIndicator.startAnimating()
        recipesLoader = RecipesLoader(ingredients: ingredients)
        recipesLoader!.load(completion: { recipes, error in
            if let error = error {
                self.showAlert(alertType: .SearchFailure)
                self.navigationItem.title = "Error"
                print("Error! " + error.localizedDescription)
            } else if (recipes.count == 0) {
                self.showAlert(alertType: .NoResults)
                self.recipesLoader!.setHasMore(hasMore: false)
                self.navigationItem.title = "No Results"
            } else {
                // Food2Fork returns at most 30 recipes on each page
                if (recipes.count < 30) {
                    self.recipesLoader!.setHasMore(hasMore: false)
                }
                self.recipes = recipes
                self.collectionView.reloadData()
                self.navigationItem.title = "Results"
            }
            self.activityIndicator.stopAnimating()
        })
    }
    
    private func loadMoreRecipes(handler: ((Void) -> Void)?) {
        if let loader = recipesLoader {
            loader.loadMore(completion: { recipes, error in
                if let error = error {
                    self.handleResponse(data: nil, error: error, completion: handler)
                } else {
                    self.handleResponse(data: recipes, error: nil, completion: handler)
                }
            })
        }
    }
    
    // Handle response when loading more recipes with infinite scroll
    private func handleResponse(data: [RecipeItem]?, error: Error?, completion: ((Void) -> Void)?) {
        if let _ = error {
            completion?()
            return
        }
        
        if (data!.count == 0) {
            self.recipesLoader?.setHasMore(hasMore: false)
            completion?()
            return
        }
        
        // Food2Fork returns at most 30 recipes on each page
        if (data!.count < 30) {
            self.recipesLoader?.setHasMore(hasMore: false)
        }
        
        var indexPaths = [NSIndexPath]()
        let firstIndex = recipes.count
        for (i, recipe) in data!.enumerated() {
            let indexPath = NSIndexPath(item: firstIndex + i, section: 0)
            recipes.append(recipe)
            indexPaths.append(indexPath)
        }
        
        collectionView?.performBatchUpdates({ () -> Void in
            (self.collectionView?.insertItems(at: indexPaths as [IndexPath]))!
            }, completion: { (finished) -> Void in
                completion?()
        });
    }
    
    func saveRecipe(sender: UIButton) {
        let index: Int = (sender.layer.value(forKey: "index")) as! Int
        let recipe = recipes[index]
        favoritesManager.addRecipe(recipe: recipe)
        Drop.down("Added to your favorites ⭐", state: Custom.Left)
        
        // Haptic feedback (available iOS 10+)
        if #available(iOS 10.0, *) {
            let savedRecipeFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
            savedRecipeFeedbackGenerator.impactOccurred()
        }
        
    }
    
    func openRecipeUrl(sender: UITapGestureRecognizer) {
        let cell = sender.view?.superview?.superview as! RecipeCollectionCell
        let webView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecipeWebView") as! RecipeWebView
        webView.recipe = cell.recipe
        webView.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        webView.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "star-navbar"), style: .plain, target: self, action: nil)
        self.navigationController?.pushViewController(webView, animated: true)
    }
    
}
