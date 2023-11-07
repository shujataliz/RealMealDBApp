//
//  RealMealDbAppTests.swift
//  RealMealDbAppTests
//
//  Created by Shujat Ali on 06/11/2023.
//

import XCTest
@testable import ApiManager
@testable import RealMealDbApp

final class RealMealDbAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testMealItems() async throws {
        let api = ApiClientAdapter(api: TestApiManager())
        let listItems = try await api.desertMealItems
        XCTAssertEqual(listItems.count, 65)
        XCTAssertEqual(listItems.first?.mealName, "Apam balik")
        XCTAssertEqual(listItems.first?.mealThumbnail, "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
        XCTAssertNotNil(listItems.first?.mealThumbnailURL)
        XCTAssertEqual(listItems.first?.id, "53049")
        
    }
    
    
    func testDetailItems() async throws {
        let api = ApiClientAdapter(api: TestApiManager())
        let detailItem = try await api.getDetailMeals("53049")
        XCTAssertEqual(detailItem?.idMeal, "53049")
        XCTAssertEqual(detailItem?.category, "Dessert")
        XCTAssertEqual(detailItem?.ingredients.count, 9)
        XCTAssertEqual(detailItem?.measures.count, 9)
    }
    
    func testFilterInMealList() async throws {
//        let viewModel = MealsViewModel()
//        //testing with static data
//        let api = ApiClientAdapter(api: TestApiManager())
////        
//        try await viewModel.getMeals(api)
//        viewModel.search = "Apple"
////        //As search Apam balik is only 3
//        XCTAssertEqual(viewModel.filteredItems.count, 3)
    }
    
    
    func testMealDetails() async throws {
        //let viewModel = MealDetailViewModel(mealId: "53049")
    }

}

class TestApiManager: ApiManager {

    func data(from url: URL) async throws -> (Data, URLResponse) {
        try await data(from: url, delegate: nil)
    }

    func data(from url: URL, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        try await Task {
            
            let file = url.absoluteString.hasSuffix("c=Dessert") ? "desert" : "desert_detail"
            guard let fileUrl = Bundle(for: Self.self).url(forResource: file, withExtension: ".json") else {
                return (Data(), HTTPURLResponse.notFound(url: url))
            }
            let data = try Data(contentsOf: fileUrl)
            return (data, HTTPURLResponse.ok(url: url))
        }.value
    }
}

private extension HTTPURLResponse {

    static func ok(url: URL) -> Self {
        self.init(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
    }

    static func notFound(url: URL) -> Self {
        self.init(url: url, statusCode: 404, httpVersion: nil, headerFields: nil)!
    }
}


