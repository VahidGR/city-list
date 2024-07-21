//
//  BinarySearch.swift
//  city-list
//
//  Created by Vahid Ghanbarpour on 7/20/24.
//

import Foundation

extension Tools {
    /// A divide and conquer algorithm best used for sorted arrays
    static func binarySearch<Model: BinaryComparable>(_ type: Model.Type) -> BinarySearch<Model> {
        BinarySearch<Model>()
    }
}

extension Tools {
    /// A combination of two binary search methods to find the first and last matching indexes, slicing the array between these two in order to filter conditioned search in oppose to `StandardLibrary`'s `filter(_:)` method
    /// - Best practice: use with sorted arrays
    /// - Also see: `https://en.wikipedia.org/wiki/Binary_search#Algorithm`
    struct BinarySearch<Element: BinaryComparable>: Explorer {
        typealias ComparisonResult = BinaryComaparison
        
        fileprivate init() { }
        
        func search(
            _ sequence: Array<Element>,
            _ isIncluded: (Element) throws -> ComparisonResult
        ) -> Array<Element> {
            
            let comparison: (Element) -> ComparisonResult = { element in
                try! isIncluded(element)
            }
            
            let lowerBound = binarySearchBound(
                sequence,
                compare: comparison,
                left: 0,
                right: sequence.count - 1,
                bound: .lower
            )
            if lowerBound == -1 { return [] }
            
            let upperBound = binarySearchBound(
                sequence,
                compare: comparison,
                left: 0,
                right: sequence.count - 1,
                bound: .upper
            )
            
            return Array(sequence[lowerBound...upperBound])
        }
        
        private func binarySearchBound(
            _ sequence: Array<Element>,
            compare: (Element) -> ComparisonResult,
            left: Int,
            right: Int,
            bound: Bound
        ) -> Int {
            if sequence.isEmpty {
                return -1
            }
            
            switch bound {
            case .lower:
                if let first = sequence.first, compare(first) == .match {
                    return 0
                }
            case .upper:
                if let last = sequence.last, compare(last) == .match {
                    return sequence.count - 1
                }
            }
            
            var left = left
            var right = right
            
            while left <= right {
                let mid = (left + right) / 2
                let item = sequence[sequence.index(sequence.startIndex, offsetBy: mid)]
                
                let direction = compare(item)
                switch direction {
                case .left:
                    left = mid + 1
                case .right:
                    right = mid - 1
                case .match:
                    
                    switch bound {
                    case .lower:
                        let subject = sequence[sequence.index(sequence.startIndex, offsetBy: mid - 1)]
                        if mid == 0 || compare(subject) != .match {
                            return mid
                        }
                        right = mid - 1
                    case .upper:
                        let subject = sequence[sequence.index(sequence.startIndex, offsetBy: mid + 1)]
                        if mid == sequence.count - 1 || compare(subject) != .match {
                            return mid
                        }
                        left = mid + 1
                    }
                }
            }
            
            return -1
        }
        
    }
    
    private enum Bound {
        case lower
        case upper
    }
}
