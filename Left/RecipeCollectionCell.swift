//
//  RecipeCollectionCell.swift
//  Left
//
//  Created by Alejandrina Patron on 8/4/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import Foundation
import UIKit

class RecipeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipePhoto: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
  
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
