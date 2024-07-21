//
//  SearchTests.swift
//  city-listTests
//
//  Created by Vahid Ghanbarpour on 7/18/24.
//

import XCTest
@testable import city_list

final class SearchTests: XCTestCase {
    
    private let metricts: [XCTMetric] = [XCTMemoryMetric(), XCTClockMetric()]
    
    private lazy var measureOptions: XCTMeasureOptions = {
        let measureOptions: XCTMeasureOptions = .default
        measureOptions.iterationCount = 1_000
        
        return measureOptions
    }()
    
    func testCustomSearchAgainstStandardLibrary() throws {
        // given
        let li_dataset: [SearchableText<Tools.StandardLibrary.ComparisonResult>] = Dataset
            .search_large_dataset
            .map({
                .init(wrapped: $0)
            })
        let bi_dataset: [SearchableText<Tools.BinarySearch.ComparisonResult>] = Dataset
            .search_large_dataset
            .map({
                .init(wrapped: $0)
            })

        let reference = Tools.standardLibrary()
        let sut = Tools.binarySearch()
        
        
        for query in alphabet {
            let expected = reference.search(li_dataset) { element in
                element.compare(against: query)
            }
                .map({ $0.wrapped })
            let found = sut.search(bi_dataset) { element in
                element.compare(against: query)
            }
                .map({ $0.wrapped })
            XCTAssertEqual(expected, found)
        }
    }
    
    func testStandardLibraryPerformance() {
        let dataset: [SearchableText<Tools.StandardLibrary.ComparisonResult>] = Dataset
            .search_large_dataset
            .map({
                .init(wrapped: $0)
            })
        let sut = Tools.standardLibrary()
        
        self.measure(options: measureOptions) {
            for query in alphabet {
                let _ = sut.search(dataset) { element in
                    element.compare(against: query)
                }
            }
        }
    }
    
    func testBinarySearchPerformance() {
        let dataset: [SearchableText<Tools.BinarySearch.ComparisonResult>] = Dataset
            .search_large_dataset
            .map({
                .init(wrapped: $0)
            })
        let sut = Tools.binarySearch()
        
        self.measure(options: measureOptions) {
            for query in alphabet {
                let _ = sut.search(dataset) { element in
                    element.compare(against: query)
                }
            }
        }
    }
    
}
