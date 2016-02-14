//
//  RecipeCell.swift
//  Left
//
//  Created by Alejandrina Patron on 2/14/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {
    
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImg: UIImageView!
    
    var recipe: RecipeItem! {
        didSet {
            recipeName.text = recipe.name
            if let photo = recipe.photo {
                recipeImg.contentMode = UIViewContentMode.ScaleAspectFit
                recipeImg.image = photo
            }
            
        }
    }
}

