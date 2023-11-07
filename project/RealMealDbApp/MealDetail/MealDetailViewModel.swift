//
//  MealDetailViewModel.swift
//  RealMealDbApp
//
//  Created by Shujat Ali on 07/11/2023.
//

import Foundation
import ApiManager

class MealDetailViewModel: ObservableObject {
    var mealId: String
    
    @Published
    var detailItem: MealDetailItem?
    
    var mealImage: URL? {
        return URL(string: detailItem?.mealThumb ?? "")
    }
    
    var headLines: String {
        if let detailItem = detailItem {
            var headlines = [String]()
            if !detailItem.area.isEmpty {
                headlines.append("AREA --> \(detailItem.area)")
            }
            
            if !detailItem.category.isEmpty {
                headlines.append("CATEGORY --> \(detailItem.category)")
            }
            
            if let tags = detailItem.tags, !tags.isEmpty {
                headlines.append("TAGS --> \(tags)")
            }
            
            if let _ = URL(string: detailItem.youtube) {
                headlines.append("Youtube")
                headlines.append("[\(detailItem.youtube)](" + detailItem.youtube + ")")
            }
            
            if let _ = URL(string: detailItem.source) {
                headlines.append("Source")
                headlines.append("[\(detailItem.source)](" + detailItem.source + ")")
            }
            
            if detailItem.ingredients.count > 0 {
                headlines.append("\n\n")
                
                headlines.append("**Ingredients/measurements**")
                for index in 0 ..< detailItem.ingredients.count {
                    headlines.append("✤ " + detailItem.measures[index] + " " + detailItem.ingredients[index])
                }
            }
        
            
            return """
                **HEADLINES**
                \(headlines.joined(separator: "\n"))
                """
        } else {
            return ""
        }
    }
    
    var detailInstructions: String {
        if let detailItem = detailItem, !detailItem.instructions.isEmpty {
            return "**Instructions**: " + detailItem.instructions
        } else {
            return ""
        }
    }
    
    init(mealId: String) {
        self.mealId = mealId
    }
    
    func fetchDetail() async throws {
        let api = ApiClientAdapter()
        detailItem = try await api.getDetailMeals(mealId)
    }
}
