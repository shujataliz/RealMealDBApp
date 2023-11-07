//
//  MealsViewModel.swift
//  RealMealDbApp
//
//  Created by Shujat Ali on 07/11/2023.
//

import SwiftUI
import ApiManager

let THUMB_IMG_SIZE = 50.0

struct RowItem: View {
    let meal: MealItem
    var body: some View {
        HStack {
            AsyncImage(url: meal.mealThumbnailURL) { imagePhase in
                if let image = imagePhase.image {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: THUMB_IMG_SIZE, height: THUMB_IMG_SIZE)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                } else if imagePhase.error != nil {
                    Image(systemName: "photo")
                        .frame(width: THUMB_IMG_SIZE, height: THUMB_IMG_SIZE)
                } else {
                    ProgressView()
                }
            }
            
            Text("\(meal.mealName)\n\(meal.id)")
                .font(.body)
        }
    }
}

public class MealsViewModel: ObservableObject {
    @Published var meals: [MealItem] = [MealItem]()
    
    public var filteredItems: [MealItem] {
        if search.isEmpty {
            return meals
        } else {
            return meals.filter { $0.mealName.lowercased().contains(search.lowercased()) }
        }
    }
    
    @Published public var search: String = ""
    
    public func getMeals(_ api: ApiClientAdapter = ApiClientAdapter()) async throws {
        meals = try await api.desertMealItems.sorted()
    }
}
