//
//  LFTRecipeCollectionCell.swift
//  Left
//
//  Created by Alejandrina Patron on 6/9/17.
//  Copyright © 2017 Ale Patrón. All rights reserved.
//

import UIKit

class RecipeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var recipePhoto: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    
    var recipe: RecipeItem! {
        didSet {
            recipeName.text = recipe.name
            recipePhoto.contentMode = UIViewContentMode.scaleAspectFill
            recipePhoto.clipsToBounds = true
            if recipe.photo != nil {
                recipePhoto.image = recipe.photo
            }
        }
    }
}
