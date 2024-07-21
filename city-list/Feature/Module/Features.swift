//
//  Features.swift
//  city-list
//
//  Created by Vahid Ghanbarpour on 7/17/24.
//

import SwiftUI

internal struct Features {
    
    static func SearchableList<Resource: SearchableResources>(
        resources: Resource
    ) -> some View where Resource.Element: CellRepresentable, Resource.Search.Element: Decodable {
        let viewModel = SearchableListViewModel.init(
            resources: resources
        )
        return SearchableListView(viewModel: viewModel)
    }
    
}
