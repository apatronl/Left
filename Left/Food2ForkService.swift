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
    
    static func recipesForIngredients(ingredients: String, page: Int, completion: @escaping ([RecipeItem], Error?) -> ()) {
        var urlString = url + ingredients + "&page=\(page)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
        print(urlString)
        Alamofire.request(urlString).responseJSON { response in
            switch response.result {
            case .success :
                let result = JSON(response.result.value!)
                let recipes = JSONParser.parseRecipes(data: result)
                completion(recipes, nil)
            case .failure(let error):
                completion([], error)
            }
        }
    }
}
