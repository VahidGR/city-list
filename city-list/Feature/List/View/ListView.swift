//
//  ListView.swift
//  city-list
//
//  Created by Vahid Ghanbarpour on 7/17/24.
//

import SwiftUI

/// Used for any set of items conforming to ``CellRepresentable`` protocol and give it the ability to search
struct SearchableListView<ViewModel: SearchableViewModel>: View
where ViewModel.Resource.Element: CellRepresentable
{
    
    @StateObject var viewModel: ViewModel
    @State private var searchQuery: String = ""
    
    var body: some View {
        NavigationStack {
            ListView<ViewModel>()
                .environmentObject(viewModel)
        }
        .searchable(text: $searchQuery)
        .onChange(of: searchQuery) { query in
            viewModel.find(query)
        }
    }
}

/// Used for any set of items conforming to ``CellRepresentable`` protocol
struct ListView<ViewModel: ListViewModel>: View
where ViewModel.Resource.Element: CellRepresentable
{
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        Table(viewModel.list) {
            TableColumn ( "list_element" ) { element in
                VStack(alignment: .leading) {
                    Text(element.title)
                        .font(.headline)
                    Text(element.subtitle)
                        .font(.subheadline)
                }
            }
        }
        .onAppear(perform: viewModel.viewDidAppear)
    }
}
