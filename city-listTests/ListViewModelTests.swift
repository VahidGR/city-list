//
//  ListViewModelTests.swift
//  city-listTests
//
//  Created by Vahid Ghanbarpour on 7/18/24.
//

import XCTest
@testable import city_list

final class ListViewModelTests: XCTestCase {
    
    private weak var reference_resource: (any SearchableResources)!
    private weak var sut_resource: (any SearchableResources)!
    private let metricts: [XCTMetric] = [XCTMemoryMetric(), XCTStorageMetric(), XCTClockMetric()]
    
    override func tearDown() {
        XCTAssertNil(reference_resource)
        XCTAssertNil(sut_resource)
        super.tearDown()
    }
    
    private lazy var measureOptions: XCTMeasureOptions = {
        let measureOptions: XCTMeasureOptions = .default
        measureOptions.iterationCount = 1
        
        return measureOptions
    }()
    
    func testLoadAndSearchTime_standardLibrary() {
        
        let reference_resource = LinearResource(
            organizer: Tools.standardSort(),
            explorer: Tools.standardLibrary(SearchableText.self),
            sortedArray: Dataset.search_large_dataset.map({ .init(wrapped: $0) })
        )
        
        let sut = SearchableListViewModel(
            resources: reference_resource
        )
        sut.viewDidAppear()
        
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
        
        self.reference_resource = reference_resource
    }
    
    func testLoadAndSearchTime_binarySearch() {
        
        let sut_resource = BinaryResource(
            organizer: Tools.standardSort(),
            explorer: Tools.binarySearch(SearchableText.self),
            sortedArray: Dataset.search_large_dataset.map({ .init(wrapped: $0) })
        )
        
        let sut = SearchableListViewModel(
            resources: sut_resource
        )
        sut.viewDidAppear()
        
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
        
        self.sut_resource = sut_resource
    }
}
