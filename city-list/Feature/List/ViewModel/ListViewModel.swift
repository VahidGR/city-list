//
//  ListViewModel.swift
//  city-list
//
//  Created by Vahid Ghanbarpour on 7/17/24.
//

import Foundation
import Combine

/// ViewModel used as a base for preparing list data.
/// Can be used separately for the simplest use.
/// A resource should be provided to get list.
/// Resource must conform to ``Resources``
protocol ListViewModel: ObservableObject {
    /// Source of truth for presentable data
    associatedtype Resource: Resources
    /// Source of truth for presentable data
    var resources: Resource { get }
    /// List of items ready to present within `View`
    var list: [Resource.Element] { get set }
    /// Implements functionality which sould run when `View`' has appeared.
    func viewDidAppear()
}

/// Enforcing searchability using ``SearchableResources`` and adding ``find(_:)`` method to search
/// based on resource's specific implementation
protocol SearchableViewModel: ListViewModel {
    /// Filter a range within `Array<Resource.Element>`
    /// - Returns: `Array<Resource.Element>`
    @discardableResult func find(_ query: String) -> [Resource.Element]
}

/// An implementation of ``SearchableViewModel`` implementing ``find(_:)`` method.
/// Providing access to an implemtation of ``SearchableResources``
internal final class SearchableListViewModel<Resource: SearchableResources>: PlainListViewModel<Resource>, SearchableViewModel where Resource.Search.Element: Decodable {
    @discardableResult func find(_ query: String) -> [Resource.Element] {
        let result: [Resource.Element]
        defer {
            self.list = result
        }
        guard let query = query as? Resource.Search.Element.Compared
        else {
            assertionFailure("Assuming query is sent by `View`, cast `query` properly to `Resource.Element.Compared`")
            result = []
            return result
        }
        result = resources.find(query)
        return result
    }
}

/// An implementaion of ``ListViewModel`` providing access to an implemtation of ``Resources`` and a `@Published` property of ``list``
internal class PlainListViewModel<Resource: Resources>: ListViewModel {
    typealias Element = Resource.Element
    @Published internal var list: [Resource.Element]
    private(set) var resources: Resource
    
    internal init(resources: Resource) {
        self.resources = resources
        self.list = []
    }
    
    func viewDidAppear() {
        sortedList()
    }
    
}

extension ListViewModel {
    fileprivate func sortedList() {
        self.list = resources.list
    }
}
