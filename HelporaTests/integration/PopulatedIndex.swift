//
//  PopulatedIndex.swift
//  Helpora Unit Tests
//
//  Created by Alan Chu on 3/14/18.
//  Copyright © 2018 Aeta. All rights reserved.
//

import Helpora
import XCTest

class PopulatedIndexIntegrationTests: XCTestCase {
    func test() {
        var index = HPAIndex(identifier: "com.helpora.populatedindexintegrationtest", name: "Helpora Populated Index Integration Test Helpora", locale: Locale(identifier: "en_US"), title: "Helpora Populated Index Integration Test")
        let identifier = "com.helpora.populatedindexintegrationtest.section_one"
        let indexOfSection = index.addSection(identifier: "section_one", name: "Section One")
        
        XCTAssertEqual(index.sections[indexOfSection].identifier, identifier)
        XCTAssertEqual(index.sections.count, 1)
        
        print(index)
    }
}
