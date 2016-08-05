//
//  Food2ForkService.swift
//  Left
//
//  Created by Alejandrina Patron on 8/3/16.
//  Copyright © 2016 Ale Patrón. All rights reserved.
//

import Alamofire
import SwiftyJSON

public struct Food2ForkService {
    
    private static let apiKey: String = "YOUR_API_KEY"
    private static let url: String = "http://food2fork.com/api/search?key=" + apiKey + "&q="
    
    public static func recipesForIngredients(ingredients: String, completion: ([RecipeItem]) -> ()) {
        let urlString = url + ingredients
        
        Alamofire.request(.GET, urlString).validate().responseJSON { response in
            switch response.result {
            case .Success :
                let result = JSON(response.result.value!)
                let recipes = JSONParser.parseRecipes(result)
                completion(recipes)
            case .Failure:
                print("Error!")
            }
        }
    }
    
}


