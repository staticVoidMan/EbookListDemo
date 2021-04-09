//
//  EbookListRobot.swift
//  EbookListDemoUITests
//
//  Created by Amin Siddiqui on 09/04/21.
//

import XCTest

class EbookListRobot {
    
    let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    lazy var tableView: XCUIElement = app.tables["eBookTableView"]
    lazy var searchField: XCUIElement = tableView.children(matching: .searchField).element
    
    @discardableResult
    func numberOfEbooks(predicate: NSPredicate, timeout: TimeInterval = 2) -> Self {
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: tableView.cells)
        guard XCTWaiter.wait(for: [expectation], timeout: timeout) == .completed
        else { XCTAssert(false, "List count mismatch"); return self; }
        return self
    }
    
    @discardableResult
    func searchEbooks(containing searchTerm: String) -> Self {
        searchField.tap()
        searchField.typeText(searchTerm)
        app.keyboards.buttons["Search"].tap()
        return self
    }
    
}
