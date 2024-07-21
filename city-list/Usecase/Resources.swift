//
//  Resources.swift
//  city-list
//
//  Created by Vahid Ghanbarpour on 7/18/24.
//

import Foundation

/// A blueprint for a resource to contain a ``list`` and be able to `sort` it using ``Organizer``.
/// Is able to read local files, just like `cities.json` provided in the assignment description.
protocol Resources {
    associatedtype Element: Comparable
    typealias Collection = Array<Element>
    /// Sorting interface
    var organizer: Organizer { get }
    /// Best practice is to implement ``list`` as a `lazy` property and sort is using  ``Organizer``.
    var list: Array<Element> { get set }
}

/// Based on ``Resources`` providing search capabilities through ``Explorer`` interface and ``find(_:)`` method
protocol SearchableResources: Resources where Element: AlgoComparable {
    associatedtype Search: Explorer
    /// Searching interface
    var explorer: Search { get }
    /// Search method
    func find(_ query: Element.Compared) -> Array<Element>
}

extension SearchableResources where Self.Element: BiAlgoComparable {
    /// search through ``explorer``
    func filter(
        _ query: Element.Compared,
        _ isIncluded: (Element) throws -> Self.Search.ComparisonResult
    ) -> Array<Element> {
        explorer.search(list, isIncluded)
    }
}

/// All business logic related to ``CityModel``
final class Cities<Search: Explorer>: SearchableResources {
    typealias Element = CityModel<Search.ComparisonResult>
    
    func find(_ query: Element.Compared) -> Array<Element> {
        self.filter(query) { element in
            element.compare(against: query)
        }
    }
    
    let organizer: Organizer
    let explorer: Search
    
    init(organizer: Organizer, explorer: Search) {
        self.organizer = organizer
        self.explorer = explorer
    }
    
    private lazy var repository = try! read(
        file: "cities",
        withExtension: "json",
        into: Collection.self,
        bundle: .main
    )
    
    lazy var list: Array<Element> = organizer.sorted(repository, by: <)
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
