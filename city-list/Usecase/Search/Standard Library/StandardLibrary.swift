//
//  StandardLibrary.swift
//  city-list
//
//  Created by Vahid Ghanbarpour on 7/20/24.
//

import Foundation

extension Tools {
    /// Implementation of ``Organizer`` and ``Explorer`` intefaces using `Swift` `StandardLibrary`
    static func standardLibrary<Model: FilterComparable>(_ type: Model.Type) -> StandardLibrary<Model> {
        StandardLibrary<Model>()
    }
    static func standardSort() -> StandardSort {
        StandardSort()
    }
	static func sortableByKeys() -> SortableByKey {
		SortableByKey()
    }
}

extension Tools {
    struct StandardLibrary<Element: FilterComparable>: Explorer {
        typealias ComparisonResult = Bool
        
        fileprivate init() { }
        
        func search(_ sequence: Array<Element>, _ isIncluded: (Element) throws -> ComparisonResult) -> Array<Element> {
            (try? sequence.filter(isIncluded)) ?? []
        }
    }
    
    struct StandardSort: Organizer {
        
        fileprivate init() { }
        
        func sorted<Collection>(
            _ collection: Collection,
            by areInIncreasingOrder: (Collection.Element, Collection.Element) throws -> Bool
        ) rethrows -> Array<Collection.Element> where Collection : RandomAccessCollection {
            try collection.sorted(by: areInIncreasingOrder)
        }
    }
	
	struct SortableByKey: DecodableOrganizer, Organizer {
		func sorted<Collection>(
			_ collection: Collection,
			by areInIncreasingOrder: (Collection.Element, Collection.Element) throws -> Bool
		) rethrows -> Array<Collection.Element> where Collection : RandomAccessCollection {
			try Tools.standardSort().sorted(collection, by: areInIncreasingOrder)
		}
		
		func sorted<Element>(
			_ collection: Array<Element>,
			forKey key: Element.CodingKeys,
			by areInIncreasingOrder: (Element, Element) throws -> Bool
		) rethrows -> Array<Element> where Element : CodedComparable {
			collection.sorted { lhs, rhs in
				lhs.compare(against: rhs, withKey: key, by: areInIncreasingOrder)
			}
		}
	}
}
