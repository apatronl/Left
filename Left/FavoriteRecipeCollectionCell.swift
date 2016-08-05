//
//  RecipeCollectionCell.swift
//  Left
//
//  Created by Alejandrina Patron on 7/22/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import Foundation
import UIKit

class FavoriteRecipeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var recipePhoto: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    var recipe: RecipeItem! {
        didSet {
            recipeName.text = recipe.name
            recipePhoto.contentMode = UIViewContentMode.ScaleAspectFill
            recipePhoto.clipsToBounds = true
            if recipe.photo != nil {
                recipePhoto.image = recipe.photo
            }
        }
    }
}
