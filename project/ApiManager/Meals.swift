//
//  Meals.swift
//  ApiManager
//
//  Created by Shujat Ali on 06/11/2023.
//

import Foundation


struct Meals: Codable {
    var meals: [MealItem]
}

public struct MealItem: Identifiable, Codable, Comparable {
    
    public var id: String
    public var mealName: String
    public var mealThumbnail: String
    public var mealThumbnailURL: URL? {
        return URL(string: mealThumbnail)
    }
    
    public static func <(lhs: MealItem, rhs: MealItem) -> Bool {
        return lhs.mealName < rhs.mealName
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case mealName = "strMeal"
        case mealThumbnail = "strMealThumb"
    }
}
