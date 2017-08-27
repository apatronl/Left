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
    
    private static let API_KEY: String = "570024717057c65d605c4d54f84f2300"
    private static let BASE_URL: String = "http://food2fork.com/api/search?key=" + API_KEY + "&q="
    
    static func recipesForIngredients(ingredients: String, page: Int, completion: @escaping ([RecipeItem], Error?) -> ()) {
        var urlString = BASE_URL + ingredients + "&page=\(page)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        Alamofire.request(urlString).responseJSON { response in
            switch response.result {
            case .success:
                let result = JSON(response.result.value!)
                let recipes = JSONParser.parseRecipes(data: result)
                completion(recipes, nil)
            case .failure(let error):
                completion([], error)
            }
        }
    }
}
