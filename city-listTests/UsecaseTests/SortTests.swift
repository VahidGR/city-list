//
//  SortTests.swift
//  city-listTests
//
//  Created by Vahid Ghanbarpour on 7/17/24.
//

import XCTest
@testable import city_list

final class SortTests: XCTestCase {
    
    func testStandardLibrary() {
        // given
        let sut: Organizer = Tools.standardSort()
        let dataset = Dataset.sort_dataset_1
        // when
        let output = sut.sorted(dataset.input, by: { $0 < $1 })
        // then
        XCTAssertEqual(output, dataset.output)
    }
    
}
