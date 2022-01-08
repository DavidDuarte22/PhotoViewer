//
//  PhotoViewerUITests.swift
//  PhotoViewerUITests
//
//  Created by David Duarte on 10/12/2021.
//

import XCTest

class PhotoViewerUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.activate()
        app.collectionViews.children(matching: .cell).element(boundBy: 5).tap()
        let closeButton = app.buttons["Close"]
        //TODO: Improve the wait. Should use a mocked UIImage instead.
        
        XCTAssertTrue(closeButton.waitForExistence(timeout: 12))
        app/*@START_MENU_TOKEN@*/.buttons["love"]/*[[".cells.buttons[\"love\"]",".buttons[\"love\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        closeButton.tap()
        app.tabBars["Tab Bar"].buttons["bookmark"].tap()
        app.tables/*@START_MENU_TOKEN@*/.buttons["love"]/*[[".cells.buttons[\"love\"]",".buttons[\"love\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
                
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testErrorExample() throws {
        
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
