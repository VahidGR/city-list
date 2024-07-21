//
//  ResourceTests.swift
//  city-listTests
//
//  Created by Vahid Ghanbarpour on 7/21/24.
//

import XCTest

final class ResourceTests: XCTestCase {
    
    func testResourceSearch() {
        let sut = MockedResource<
            Tools.BinarySearch
        >(organizer: Tools.standardLibrary(), explorer: Tools.binarySearch())
        
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
        let sut = Cities<
            Tools.BinarySearch
        >(organizer: Tools.standardLibrary(), explorer: Tools.binarySearch())
        
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
        let reference = Cities(organizer: Tools.standardLibrary(), explorer: Tools.standardLibrary())
        let sut = Cities(organizer: Tools.standardLibrary(), explorer: Tools.binarySearch())

        
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
