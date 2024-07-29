//
//  Resources.swift
//  city-list
//
//  Created by Vahid Ghanbarpour on 7/18/24.
//

import Foundation

/// A blueprint for a resource to contain a ``list`` and be able to `sort` it using ``Organizer``.
/// Is able to read local files, just like `cities.json` provided in the assignment description.
protocol Resources: AnyObject {
    associatedtype Element: Comparable
    typealias Collection = Array<Element>
	associatedtype Sort: Organizer
    /// Sorting interface
    var organizer: Sort { get }
    /// Best practice is to implement ``list`` as a `lazy` property and sort is using  ``Organizer``.
    var list: Array<Element> { get set }
}

/// Based on ``Resources`` providing search capabilities through ``Explorer`` interface and ``find(_:)`` method
protocol SearchableResources: Resources {
    associatedtype Search: Explorer
    /// Searching interface
    var explorer: Search { get }
    /// Search method
    func find(_ query: Search.Element.Compared) -> Array<Element>
}
/// Manages sort and search functionalities for  ``FilterComparable``
final class LinearResource<Sort: Organizer, Search: Explorer>: SearchableResources where Search.Element: FilterComparable, Search.ComparisonResult == Search.Element.ComparisonResult, Search.Element: Decodable {
    
    typealias Element = Search.Element
    
    
    let organizer: Sort
    let explorer: Search
    
    private let fileName: String?
    private let fileExtension: String?
    private let sortedArray: [Element]
    
    
    init(
        organizer: Sort,
        explorer: Search,
        sortedArray: [Element] = [],
        fileName: String? = nil,
        fileExtension: String? = nil
    ) {
        self.organizer = organizer
        self.explorer = explorer
        self.sortedArray = sortedArray
        self.fileName = fileName
        self.fileExtension = fileExtension
    }
    
    private lazy var repository = {
        
        if let fileName, let fileExtension {
            return try! read(
                file: fileName,
                withExtension: fileExtension,
                into: Collection.self,
                bundle: .main
            )
        }
        
        return sortedArray
    }()
    lazy var list: [Element] = organizer.sorted(repository, by: <)
    
    func find(_ query: Element.Compared) -> Array<Element> {
        explorer.search(list) { element in
            element.filter(using: query)
        }
    }
}

protocol DecodableByKey: Decodable {
	associatedtype CodingKeys: CodingKey
}

/// Manages sort and search functionalities for  ``BinaryComparable``
final class BinaryResource<Sort: Organizer, Search: Explorer>: SearchableResources where Search.Element: Decodable, Search.Element: BinaryComparable, Search.ComparisonResult == Search.Element.ComparisonResult {
    
    typealias Element = Search.Element
    
    
    let organizer: Sort
    let explorer: Search
    
    private let fileName: String?
    private let fileExtension: String?
    private let sortedArray: [Element]
    
    
    init(
        organizer: Sort,
        explorer: Search,
        sortedArray: [Element] = [],
        fileName: String? = nil,
        fileExtension: String? = nil
    ) {
        self.organizer = organizer
        self.explorer = explorer
        self.sortedArray = sortedArray
        self.fileName = fileName
        self.fileExtension = fileExtension
    }
    
    private lazy var repository = {
        
        if let fileName, let fileExtension {
            return try! read(
                file: fileName,
                withExtension: fileExtension,
                into: Collection.self,
                bundle: .main
            )
        }
        
        return sortedArray
    }()
    lazy var list: [Element] = organizer.sorted(repository, by: <)
    
    func find(_ query: Element.Compared) -> Array<Element> {
        explorer.search(list) { element in
            element.direction(against: query)
        }
    }
}

extension BinaryResource where Search.Element: DecodableBinaryComparable, Search.Element: CodedComparable, Sort: DecodableOrganizer {
	
	func find(_ query: String, forKey key: Search.Element.CodingKeys) -> Array<Element> {
		let list = organizer.sorted(repository, forKey: key) { lhs, rhs in
			lhs.compare(against: rhs, withKey: key, by: <)
		}
		
		return explorer.search(list) { element in
			element.direction(against: query, forKey: key)
		}
	}
	
}

extension Resources {
    /// Read local files within the project.
    internal func read<Format: Decodable>(
        file resourceName: String,
        withExtension resourceExtension: String,
        subdirectory subpath: String? = nil,
        localization localizationName: String? = nil,
        into format: Format.Type,
        bundle: Bundle
    ) throws -> Format {
        
        guard let url = bundle.url(
            forResource: resourceName,
            withExtension: resourceExtension,
            subdirectory: subpath,
            localization: localizationName
        ) else {
            throw LocalFileLoadingError.didNotFindPath
        }
        do {
            let data = try Data(contentsOf: url)
            do {
                let decoder = JSONDecoder()
                let formatted = try decoder.decode(format.self, from: data)
                return formatted
            } catch {
                throw LocalFileLoadingError.couldNotDecode
            }
        } catch {
            throw LocalFileLoadingError.failedToRead
        }
    }
}

enum LocalFileLoadingError: Error, Equatable {
    case failedToRead
    case couldNotDecode
    case didNotFindPath
}
