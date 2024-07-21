//
//  ResourcesTests.swift
//  city-listTests
//
//  Created by Vahid Ghanbarpour on 7/19/24.
//

import XCTest
@testable import city_list

final class ResourcesTests: XCTestCase {

    func testReadFileSuccessfully() {
        
        let sut: LinearResource = .init(
            organizer: Tools.standardSort(),
            explorer: Tools.standardLibrary(CityModel.self),
            fileName: "cities",
            fileExtension: "json"
        )
        
        XCTAssertNoThrow(
            try sut.read(file: "cities", withExtension: "json", into: [CityModel].self, bundle: .main)
        )
    }
    
    func testReadFileThatDoesNotExist() {
        let sut: LinearResource = .init(
            organizer: Tools.standardSort(),
            explorer: Tools.standardLibrary(SearchableText.self),
            fileName: "skyscrapers",
            fileExtension: "json"
        )
        
        XCTAssertThrowsError(
            try sut.read(file: "skyscrapers", withExtension: "json", into: [SearchableText].self, bundle: .main)
        ) { exception in
            let error = exception as? LocalFileLoadingError
            XCTAssertNotNil(error)
            XCTAssertEqual(error, LocalFileLoadingError.didNotFindPath)
        }

    }
    
    func testReadFileWithFaultyDecoding() {
        let sut: LinearResource = .init(
            organizer: Tools.standardSort(),
            explorer: Tools.standardLibrary(SearchableText.self),
            fileName: "cities",
            fileExtension: "json"
        )
        
        XCTAssertThrowsError(
            try sut.read(file: "cities", withExtension: "json", into: [SearchableText].self, bundle: .main)
        ) { exception in
            let error = exception as? LocalFileLoadingError
            XCTAssertNotNil(error)
            XCTAssertEqual(error, LocalFileLoadingError.failedToRead)
        }
    }
    
}
