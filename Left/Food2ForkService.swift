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
    
    private static let apiKey: String = "570024717057c65d605c4d54f84f2300"
    private static let url: String = "http://food2fork.com/api/search?key=" + apiKey + "&q="

    public static func recipesForIngredients(ingredients: String, page: Int, completion: ([RecipeItem], NSError?) -> ()) {
        // TODO: make sure url is valid (no spaces, etc)
        let urlString = url + ingredients + "&page=\(page)" 
        
        Alamofire.request(.GET, urlString).validate().responseJSON { response in
            switch response.result {
            case .Success :
                let result = JSON(response.result.value!)
                let recipes = JSONParser.parseRecipes(result)
                completion(recipes, nil)
            case .Failure(let error):
                completion([], error)
            }
        }
    }
}


