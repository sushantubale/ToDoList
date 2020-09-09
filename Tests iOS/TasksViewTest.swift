//
//  TasksViewTest.swift
//  Tests iOS
//
//  Created by Sushant-Old on 8/16/20.
//

import XCTest

class TasksViewTest: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        app = XCUIApplication()
        app.launchArguments = ["UI_TESTING"]
        app.launch()
        app.tabBars["Tab Bar"].buttons["gauge"].tap()
        let tabBarsQuery = XCUIApplication().tabBars
        tabBarsQuery.buttons.element(boundBy: 2).tap()
        XCTAssertTrue(app.scrollViews.children(matching: .button).matching(identifier: "2\nInbox").element(boundBy: 0).exists)
    }
}


