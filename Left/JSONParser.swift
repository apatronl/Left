//
//  JSONParser.swift
//  Left
//
//  Created by Alejandrina Patron on 8/3/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import SwiftyJSON

struct JSONParser {
    
    static func parseRecipes(data: JSON) -> [RecipeItem] {
        return self.JSONObjectsFromData(data)?.map(self.parseRecipe) ?? []
    }
    
//    static func parseRecipesArray(data: JSON?) -> [RecipeItem] {
//        if let data = data {
//            if let array = data["recipes"].array {
//                return array.map(self.parseRecipe) ?? []
//            }
//        }
//        return []
//    }
    
    
    private static func parseRecipe(recipe: JSON) -> RecipeItem {
        
        let name = recipe["title"].string ?? ""
        let url: String = recipe["source_url"].string ?? ""
        let photo: UIImage? = recipe["image_url"].string!.urlToImg()
        
        
        return RecipeItem(name: name, photo: photo, url: url)
    }
    
    // MARK: Helper
    
    private static func JSONObjectsFromData(data: JSON?) -> [JSON]? {
        if let data = data {
            if let items = data["recipes"].array {
                return items
            }
        }
        return nil
    }
    
}
