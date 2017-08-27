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
        return self.JSONObjectsFromData(data: data)?.map(self.parseRecipe) ?? []
    }
    
    // MARK: Helper
    
    private static func parseRecipe(recipe: JSON) -> RecipeItem {
        let name = (recipe["title"].string ?? "").verifyRecipeName()
        let url: String = recipe["source_url"].string ?? ""
        let photoURL: String = recipe["image_url"].string!
        return RecipeItem(name: name, photoUrl: photoURL, photo: nil, url: url)
    }
    
    private static func JSONObjectsFromData(data: JSON?) -> [JSON]? {
        if let data = data {
            if let items = data["recipes"].array {
                return items
            }
        }
        return nil
    }
    
}
