//
//  CityModelTests.swift
//  city-listTests
//
//  Created by Vahid Ghanbarpour on 7/21/24.
//

import XCTest

final class CityModelTests: XCTestCase {
    
    func testCompareBinary() {
        let sut: CityModel = .init(
            country: "Iran",
            city: "Tehran",
            id: 1,
            coordinates: .init(
                longitude: 2,
                latitude: 3
            )
        )
        
        XCTAssertEqual(sut.direction(against: "te"), .left)
    }
    
    func testCompareLinear() {
        let sut: CityModel = .init(
            country: "Iran",
            city: "Tehran",
            id: 1,
            coordinates: .init(
                longitude: 2,
                latitude: 3
            )
        )
        
        XCTAssertEqual(sut.filter(using: "te"), false)
    }
    
}
