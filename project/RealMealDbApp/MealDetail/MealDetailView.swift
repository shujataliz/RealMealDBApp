//
//  MealDetailView.swift
//  RealMealDbApp
//
//  Created by Shujat Ali on 06/11/2023.
//

import SwiftUI

struct IMGView: View {
    let url: URL?
    var body: some View {
        AsyncImage(url: url) { imagePhase in
            if let image = imagePhase.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 200)
            } else if imagePhase.error != nil {
                Image(systemName: "photo")
                    .frame(height: 200)
            } else {
                ProgressView()
            }
        }
        .padding(.bottom)
    }
}

struct MealDetailView: View {
    @ObservedObject var viewModel: MealDetailViewModel
    
    @State var loadingText: String = "Loading ..."
    
    init(_ id: String) {
        self.viewModel = MealDetailViewModel(mealId: id)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                IMGView(url: viewModel.mealImage)
                
                Text(.init(viewModel.headLines))
                
                Spacer()
                
                Text(.init(viewModel.detailInstructions))
                
                Spacer()
            }
            .padding([.leading, .trailing])
        }
        .navigationTitle(viewModel.detailItem?.meal ?? "Detail")
        .task {
            do {
                try await viewModel.fetchDetail()
            } catch {
                loadingText = error.localizedDescription
            }
        }
        
    }
}

#Preview {
    NavigationView {
        MealDetailView("53049")
    }
}
