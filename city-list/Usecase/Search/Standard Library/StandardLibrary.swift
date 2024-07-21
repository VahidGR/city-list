//
//  StandardLibrary.swift
//  city-list
//
//  Created by Vahid Ghanbarpour on 7/20/24.
//

import Foundation

extension Tools {
    /// Implementation of ``Organizer`` and ``Explorer`` intefaces using `Swift` `StandardLibrary`
    static func standardLibrary() -> StandardLibrary {
        StandardLibrary()
    }
}

extension Tools {
    struct StandardLibrary: Organizer, Explorer {
        typealias ComparisonResult = Bool
        
        fileprivate init() { }
        
        func sorted<Collection>(
            _ collection: Collection,
            by areInIncreasingOrder: (Collection.Element, Collection.Element) throws -> Bool
        ) rethrows -> Array<Collection.Element> where Collection : RandomAccessCollection {
            try collection.sorted(by: areInIncreasingOrder)
        }
        
        func search<Element: BiAlgoComparable>(
            _ sequence: Array<Element>,
            _ isIncluded: (Element) throws -> ComparisonResult
        ) -> Array<Element> {
            (try? sequence.filter(isIncluded)) ?? []
        }
    }
}
