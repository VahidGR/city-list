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

internal protocol DecodableOrganizer {
	func sorted<Element: CodedComparable>(
        _ collection: Array<Element>,
		forKey key: Element.CodingKeys,
        by areInIncreasingOrder: (Element, Element) throws -> Bool
	) rethrows -> Array<Element>
}

/// Search interface accepting `Array<Element>` input where `Element` conforms to ``AlgoComparable``
/// - Parameters: `sequence: Array<AlgoComparable>`
/// - `isIncluded: (AlgoComparable) throws -> ComparisonResult`
/// - Returns: `Array<Element>`
internal protocol Explorer {
    /// Dictates how ``search(_:_:)``'s Elements are matched
    associatedtype Element: AlgoComparable
    associatedtype ComparisonResult
    /// Shared interface method for searching algorithms. Check out ``AlgoComparable``
    func search(
        _ sequence: Array<Element>,
        _ isIncluded: (Element) throws -> ComparisonResult
    ) -> Array<Element>
}


/// Enforcing ``Compared`` conforming to `Comparable` dictating the way two elements are compared.
/// Implementation is simillar to `Equatable` but not quite.
protocol AlgoComparable: Comparable {
    /// Dictates ``compare(against:)``'s output which is fed to ``Explorer``'s `search(_:, _:)`
    /// Dictating the way two elements are compared
    associatedtype Compared: Comparable
}

/// Comparison method used for binary search algorithms
/// Conforming to ``AlgoComparable``
protocol BinaryComparable: AlgoComparable {
    /// Divide and conquer match making decision.
    typealias ComparisonResult = BinaryComaparison
    /// Decide whether a comparison is a `match` or its travelling direction in a Divide and conquer algorithm.
    func direction(against reference: Compared) -> BinaryComaparison
}

/// Comparison method used for binary search algorithms for  collections with``DecodableByKey`` elements
/// Conforming to ``DecodableBinaryComparable``
protocol DecodableBinaryComparable: BinaryComparable, DecodableByKey {
	/// Decide whether a comparison is a `match` or its travelling direction in a Divide and conquer algorithm.
	func direction(against reference: String, forKey key: CodingKeys) -> BinaryComaparison
}

/// Comparison method used for linear algorithms like `StandardLibrary`'s `filter(_:) rethrows -> [Element]`
/// Conforming to ``AlgoComparable``
protocol FilterComparable: AlgoComparable {
    /// Linear match making decision.
    typealias ComparisonResult = Bool
    /// Decide the way a comparison is a `match`
    func filter(using reference: Compared) -> Bool
}

protocol CodedComparable: DecodableByKey {
	func compare(against reference: Self, withKey key: CodingKeys, by areInIncreasingOrder: (Self, Self) throws -> Bool) -> Bool
}

/// Tools factory
internal struct Tools {
    private init() {  }
}
