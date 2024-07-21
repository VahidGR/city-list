//
//  Tools.swift
//  city-list
//
//  Created by Vahid Ghanbarpour on 7/17/24.
//

import Foundation

/// Protocol with an input of `RandomAccessCollection` and sorting function signiture of `Swift`'s `Standard Library`.
/// Designed to be a common interface for sorting algorithms.
/// - Parameters: `collection: RandomAccessCollection`
/// - `areInIncreasingOrder: (RandomAccessCollection.Element, RandomAccessCollection.Element) throws -> Bool`
/// - Returns: `Array<RandomAccessCollection.Element>`
internal protocol Organizer {
    func sorted<Collection: RandomAccessCollection>(
        _ collection: Collection,
        by areInIncreasingOrder: (Collection.Element, Collection.Element) throws -> Bool
    ) rethrows -> Array<Collection.Element>
}

/// Search interface accepting `Array<Element>` input where `Element` conforms to ``BiAlgoComparable``
/// - Parameters: `sequence: Array<BiAlgoComparable>`
/// - `isIncluded: (BiAlgoComparable) throws -> ComparisonResult`
/// - Returns: `Array<Element>`
internal protocol Explorer {
    /// Dictates how ``search(_:_:)``'s Elements are matched
    associatedtype ComparisonResult
    /// Shared interface method for searching algorithms. Check out ``BiAlgoComparable``
    func search<Element: BiAlgoComparable>(
        _ sequence: Array<Element>,
        _ isIncluded: (Element) throws -> ComparisonResult
    ) -> Array<Element>
}


/// Enforcing ``Compared`` conforming to `Comparable` dictating the way two elements are compared.
/// Implementation is simillar to `Equatable` but not quite.
protocol AlgoComparable: Comparable {
    /// Dictating the way two elements are compared
    associatedtype Compared: Comparable
}

/// Comparison method used for binary search algorithms
/// Conforming to ``AlgoComparable``
protocol BinaryComparable: AlgoComparable {
    /// Decide whether a comparison is a `match` or its travelling direction in a Divide and conquer algorithm.
    func direction(against reference: Compared) -> BinaryComaparison
}

/// Comparison method used for linear algorithms like `StandardLibrary`'s `filter(_:) rethrows -> [Element]`
/// Conforming to ``AlgoComparable``
protocol FilterComparable: AlgoComparable {
    /// Decide the way a comparison is a `match`
    func filter(using reference: Compared) -> Bool
}

/// Enforcing ``ComparisonResult`` to get comparison method off of search algorithm implementation
/// Example:
/// - ``BinaryComaparison`` for `BinarySearch`
/// - `Bool` for `StandardLibrary`
/// and is open to extend if other algorithms are introduced into the system with different comparison method requirements
protocol BiAlgoComparable: AlgoComparable where Self: FilterComparable & BinaryComparable {
    /// Dictates ``compare(against:)``'s output which is fed to ``Explorer``'s `search(_:, _:)`
    associatedtype ComparisonResult
    /// Check all implemntations of `Comparable` methods. Currently supporing ``FilterComparable`` and ``BinaryComparable``
    func compare(against reference: Compared) -> ComparisonResult
}

/// Tools factory
internal struct Tools {
    private init() {  }
}
