//
//  FavoriteRecipeCell.swift
//  Left
//
//  Created by Alejandrina Patron on 2/28/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit

class FavoriteRecipeCell: UITableViewCell {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImg: UIImageView!
    
    var recipe: RecipeItem! {
        didSet {
            recipeName.text = recipe.name
            recipeImg.contentMode = UIViewContentMode.ScaleAspectFill
            recipeImg.clipsToBounds = true
            recipeImg.image = recipe.photo
        }
    }
}