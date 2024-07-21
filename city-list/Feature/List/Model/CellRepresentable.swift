//
//  CellRepresentable.swift
//  city-list
//
//  Created by Vahid Ghanbarpour on 7/20/24.
//

import Foundation

/// A protocol to represent model as `title` & `subtitle` for any list
protocol CellRepresentable: Identifiable {
    var title: String { get }
    var subtitle: String { get }
}
