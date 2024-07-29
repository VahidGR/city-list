//
//  ResourcesTests+find.swift
//  city-listTests
//
//  Created by Vahid Ghanbarpour on 7/21/24.
//

import XCTest

final class ResourcesTests_find: XCTestCase {
    
    private weak var sut: (any SearchableResources)!
    private weak var reference: (any SearchableResources)!
    
    override func tearDown() {
        XCTAssertNil(reference)
        XCTAssertNil(sut)
        super.tearDown()
    }
    
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

        self.sut = sut
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

        self.sut = sut
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
        
        self.reference = reference
        self.sut = sut
    }
	
	func testSortCityByID() {
		let sut = BinaryResource(
			organizer: Tools.sortableByKeys(),
			explorer: Tools.binarySearch(
				CityModel.self
			),
			fileName: "cities",
			fileExtension: "json"
		)
		
		let sortedReference = Tools.standardSort().sorted(sut.list) { lhs, rhs in
			lhs.id < rhs.id
		}
		
		let target: Int = 4099679
		
		let output = sut.find(.init(target), forKey: .id)
		
		let expected = sortedReference.filter { element in
			element.id >= target
		}
		
		XCTAssertEqual(output, expected)
		
		for item in output {
			XCTAssertTrue(target <= item.id)
		}
	}
	
	/*
	func testSortCityByCoordinates() {
		let sut = BinaryResource(
			organizer: Tools.sortableByKeys(),
			explorer: Tools.binarySearch(
				CityModel.self
			),
			fileName: "cities",
			fileExtension: "json"
		)
		
		let target: CityModel.Coordinates = .init(longitude: 10, latitude: -10)
		
		let output = sut.find("10, -10", forKey: .coordinates)
		
		let sortedReference = Tools.standardSort().sorted(sut.list) { lhs, rhs in
			lhs.id < rhs.id
		}
		
		let reference = sortedReference.filter { element in
			element.coordinates >= target
		}
		
		XCTAssertEqual(output, reference)
		
		for item in output {
			XCTAssertTrue(target <= item.coordinates)
		}
	}
	 */
}
