//
//  CatAppUITests.swift
//  CatAppUITests
//
//  Created by Andres Esteban Perez Ramirez on 10/19/19.
//  Copyright © 2019 Andres Esteban Perez Ramirez. All rights reserved.
//

import XCTest

class CatAppUITests: XCTestCase {

    let app = XCUIApplication()
    
    private let breedItem = "Breeds"
    private let favoriteItem = "Favorite"
    private let voteItem = "My votes"


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        
        validateDashboard()
        app.staticTexts[breedItem].tap()
        validateBreeds()
        validateLabelWaitForExistence(str: "Abyssinian")
        app.tables.staticTexts["Abyssinian"].tap()
        validateDetailBreeds()
        app.buttons["icHearth"].tap()
        app.buttons["Love it"].tap()
        app.navigationBars["Breed Details"].buttons["Breeds"].tap()
        app.navigationBars["Breeds"].buttons["Dashboard"].tap()
        app.staticTexts[favoriteItem].tap()
        validateFavorite()
        app.navigationBars[favoriteItem].buttons["Dashboard"].tap()
        app.staticTexts[voteItem].tap()
        validateVoteItem()
        app.navigationBars[voteItem].buttons["Dashboard"].tap()
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    private func validateDashboard(){
        
        validateLabelWaitForExistence(str: "Dashboard")
        validateLabelWaitForExistence(str: breedItem)
        validateLabelWaitForExistence(str: voteItem)
        validateLabelWaitForExistence(str: favoriteItem)
    }
    
    private func validateBreeds(){
        validateLabelWaitForExistence(str: breedItem)
        validateButtonWaitForExist(str: "Back")
        validateButtonWaitForExist(str: "Refresh")
    }
    
    private func validateDetailBreeds(){
        validateButtonWaitForExist(str: "Wikipedia")
        validateLabelWaitForExistence(str: "Breed Details")
        validateButtonWaitForExist(str: breedItem)
        validateButtonWaitForExist(str: "Love it")
        validateButtonWaitForExist(str: "Nope it")
    }
    
    private func validateFavorite(){
        validateLabelWaitForExistence(str: favoriteItem)
    }
    
    private func validateVoteItem(){
        validateLabelWaitForExistence(str: voteItem)
        validateLabelWaitForExistence(str:  "You like it")
    }
        
    private func validateTextExist(str: String){
        let trackInfoLabel = app.staticTexts[str]
        XCTAssertEqual(trackInfoLabel.exists, true)
    }
    
    func validateLabelWaitForExistence(str: String) {
        let label = app.staticTexts[str]
        XCTAssertTrue(label.waitForExistence(timeout: 20))
    }
    
    func validateButtonWaitForExist(str: String) {
        let button = app.buttons[str]
        XCTAssertTrue(button.waitForExistence(timeout: 10))
    }
}
