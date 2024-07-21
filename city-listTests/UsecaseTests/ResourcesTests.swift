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
        XCTAssertNoThrow(
            try FileReaderMocked<
            Tools.StandardLibrary,
            CityModel<Tools.StandardLibrary.ComparisonResult>
            >(
                file: "cities",
                withExtension: "json",
                into: [CityModel<Tools.StandardLibrary.ComparisonResult>].self,
                bundle: .main
            )
        )
    }
    
    func testReadFileThatDoesNotExist() {
        XCTAssertThrowsError(
            try FileReaderMocked<
            Tools.StandardLibrary,
            SearchableText<Tools.StandardLibrary.ComparisonResult>
            >(
                file: "skyscrapers",
                withExtension: "json",
                into: [SearchableText<Tools.StandardLibrary.ComparisonResult>].self,
                bundle: Bundle(for: ResourcesTests.self)
            )
        ) { exception in
            let error = exception as? LocalFileLoadingError
            XCTAssertNotNil(error)
            XCTAssertEqual(error, LocalFileLoadingError.didNotFindPath)
        }
    }
    
    func testReadFileWithFaultyDecoding() {
        XCTAssertThrowsError(
            try FileReaderMocked<
            Tools.StandardLibrary,
            SearchableText<Tools.StandardLibrary.ComparisonResult>
            >(
                file: "cities",
                withExtension: "json",
                into: [SearchableText<Tools.StandardLibrary.ComparisonResult>].self,
                bundle: .main
            )
        ) { exception in
            let error = exception as? LocalFileLoadingError
            XCTAssertNotNil(error)
            XCTAssertEqual(error, LocalFileLoadingError.failedToRead)
        }
    }
    
}
