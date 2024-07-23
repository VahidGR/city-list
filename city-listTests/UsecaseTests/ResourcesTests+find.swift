//
//  ResourcesTests+find.swift
//  city-listTests
//
//  Created by Vahid Ghanbarpour on 7/21/24.
//

import XCTest

final class ResourceTests: XCTestCase {
    
    func testResourceSearch() {
        let sut = BinaryResource(
            organizer: Tools.standardSort(),
            explorer: Tools.binarySearch(SearchableText.self),
            sortedArray: Dataset.search_large_dataset.map({ .init(wrapped: $0) })
        )
        
        XCTAssertEqual(sut.list.count, 365)
        let a = sut.find("a")
        XCTAssertTrue(a.first?.wrapped.starts(with: "a") == true)
        let b = sut.find("b")
        XCTAssertTrue(b.first?.wrapped.starts(with: "b") == true)
        let c = sut.find("c")
        XCTAssertTrue(c.first?.wrapped.starts(with: "c") == true)
        let d = sut.find("d")
        XCTAssertTrue(d.first?.wrapped.starts(with: "d") == true)
        let e =  sut.find("e")
        XCTAssertTrue(e.first?.wrapped.starts(with: "e") == true)
        let list = sut.find("")
        XCTAssertEqual(list.count, 365)

    }
    
    func testResourceFilter() {
        let sut = BinaryResource(
            organizer: Tools.standardSort(),
            explorer: Tools.binarySearch(CityModel.self),
            fileName: "cities",
            fileExtension: "json"
        )
        
        XCTAssertEqual(sut.list.count, 209557)
        let a = sut.find("a")
        XCTAssertTrue(a.first?.city.starts(with: "a") == true)
        let b = sut.find("b")
        XCTAssertTrue(b.first?.city.starts(with: "b") == true)
        let c = sut.find("c")
        XCTAssertTrue(c.first?.city.starts(with: "c") == true)
        let d = sut.find("d")
        XCTAssertTrue(d.first?.city.starts(with: "d") == true)
        let e =  sut.find("e")
        XCTAssertTrue(e.first?.city.starts(with: "e") == true)
        let list = sut.find("")
        XCTAssertEqual(list.count, 209557)

    }
    
    func testCustomSearchAgainstStandardLibrary() throws {
        // given
        let reference = LinearResource(
            organizer: Tools.standardSort(),
            explorer: Tools.standardLibrary(CityModel.self)
        )
        let sut = BinaryResource(
            organizer: Tools.standardSort(),
            explorer: Tools.binarySearch(CityModel.self)
        )

        
        for query in alphabet {
            // when
            let expected = reference.find(query)
                .map({ $0.city })
            let found = sut.find(query)
                .map({ $0.city })
            // then
            XCTAssertEqual(expected, found)
        }
    }
}
