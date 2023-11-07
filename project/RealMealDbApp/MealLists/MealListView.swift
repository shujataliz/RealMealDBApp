//
//  MealListView.swift
//  RealMealDbApp
//
//  Created by Shujat Ali on 06/11/2023.
//

import SwiftUI

struct MealListView: View {
    
    @ObservedObject var viewModel = MealsViewModel()
    
    var body: some View {
        VStack {
            List(viewModel.filteredItems) { item in
                NavigationLink(destination: MealDetailView(item.id)) {
                    RowItem(meal: item)
                }
            }
            Spacer()
        }
        .searchable(text: $viewModel.search, prompt: "Search here")
        .task {
            do {
                try await viewModel.getMeals()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    NavigationView {
        MealListView()
    }
}
