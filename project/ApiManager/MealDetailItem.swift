//
//  MealDetailItem.swift
//  ApiManager
//
//  Created by Shujat Ali on 06/11/2023.
//

import Foundation


struct MealDetailResponse: Codable {
    var meals: [MealDetailItem]
}

public struct MealDetailItem: Codable {
    public let idMeal: String
    public let meal: String
    public let drinkAlternate: String?
    public let category: String
    public let area: String
    public let instructions: String
    public let mealThumb: String
    public let tags: String?
    public let youtube: String
    public var ingredients: [String] = []
    public var measures: [String] = []
    public let source: String
    public let imageSource: String?
    public let creativeCommonsConfirmed: String?
    public let dateModified: String?
    
    enum CodingKeys: String, CodingKey {
        case idMeal, meal = "strMeal", drinkAlternate = "strDrinkAlternate", category = "strCategory", area = "strArea"
        case instructions = "strInstructions", mealThumb = "strMealThumb", tags = "strTags", youtube = "strYoutube"
        case source = "strSource", imageSource = "strImageSource"
        case creativeCommonsConfirmed = "strCreativeCommonsConfirmed", dateModified = "dateModified"
    }
    
    enum ExtraKeys: String, CodingKey {
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        meal = try container.decode(String.self, forKey: .meal)
        drinkAlternate = try container.decode(String?.self, forKey: .drinkAlternate)
        category = try container.decode(String.self, forKey: .category)
        area = try container.decode(String.self, forKey: .area)
        instructions = try container.decode(String.self, forKey: .instructions)
        mealThumb = try container.decode(String.self, forKey: .mealThumb)
        tags = try container.decode(String?.self, forKey: .tags)
        youtube = try container.decode(String.self, forKey: .youtube)
        
        source = try container.decode(String.self, forKey: .source)
        imageSource = try container.decode(String?.self, forKey: .imageSource)
        creativeCommonsConfirmed = try container.decode(String?.self, forKey: .creativeCommonsConfirmed)
        dateModified = try container.decode(String?.self, forKey: .dateModified)
        
        let container2 = try decoder.container(keyedBy: ExtraKeys.self)
        for i in 1...20 {
            if let ingredient = try? container2.decodeIfPresent(String.self, forKey: ExtraKeys(rawValue: "strIngredient\(i)")!), !ingredient.trimmingCharacters(in: .whitespaces).isEmpty {
                ingredients.append(ingredient)
            }
            if let measure = try? container2.decodeIfPresent(String.self, forKey: ExtraKeys(rawValue: "strMeasure\(i)")!), !measure.trimmingCharacters(in: .whitespaces).isEmpty {
                measures.append(measure)
            }
        }
    }
}
