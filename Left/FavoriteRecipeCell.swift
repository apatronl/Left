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
            if let photo = recipe.photo {
                recipeImg.contentMode = UIViewContentMode.ScaleAspectFill
                recipeImg.clipsToBounds = true
                recipeImg.image = photo
            }
        }
    }
}