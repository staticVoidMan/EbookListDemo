//
//  EbookListVCUITests.swift
//  EbookListDemoUITests
//
//  Created by Amin Siddiqui on 09/04/21.
//

import XCTest

class EbookListVCUITests: XCTestCase {
    
    var eBookListRobot: EbookListRobot!
    
    override func setUp() {
        super.setUp()
        
        let app = XCUIApplication()
        app.launchArguments = ["enable-ui-testing"]
        app.launch()
        
        eBookListRobot = EbookListRobot(app: app)
    }
    
    func testCanSearchAndLoadFirstTenBooks() {
        eBookListRobot
            .numberOfEbooks(predicate: NSPredicate(format: "count == 0"))
            .searchEbooks(containing: "Lord of the Rings")
            .numberOfEbooks(predicate: NSPredicate(format: "count > 0"))
    }
    
}
