//
//  ApiClientAdapter.swift
//  ApiManager
//
//  Created by Shujat Ali on 06/11/2023.
//

import Foundation

import Combine


let BASE_URL = "https://themealdb.com/api/json/v1/1/"
public struct ApiClientAdapter {
    
    private let api: ApiManager
    
    public init(api: ApiManager = URLSession.shared) {
        self.api = api
    }
    
    public var desertMealItems: [MealItem] {
        get async throws {
            let model = try await callGlobalApi(ofType: Meals.self, param: "filter.php?c=Dessert")
            return model.meals
        }
    }
    
    public func getDetailMeals(_ id: String) async throws -> MealDetailItem?  {
        let model = try await callGlobalApi(ofType: MealDetailResponse.self, param: "lookup.php?i=" + id)
        return model.meals.first
    }
    
    private func callGlobalApi<D: Decodable>(ofType type: D.Type, param: String) async throws -> D {
        guard let url = URL(string: BASE_URL + param) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await api.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(type, from: data)
    }
}


