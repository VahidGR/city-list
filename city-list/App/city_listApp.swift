//
//  city_listApp.swift
//  city-list
//
//  Created by Vahid Ghanbarpour on 7/17/24.
//

import SwiftUI

@main
struct city_listApp: App {
    
    var body: some Scene {
        WindowGroup {
            AppMainScreen()
        }
    }
}

fileprivate struct AppMainScreen: View {
    
    let resources = BinaryResource(
        organizer: Tools.standardSort(),
        explorer: Tools.binarySearch(CityModel.self),
        fileName: "cities",
        fileExtension: "json"
    )
    
    var body: some View {
        Features.SearchableList(resources: resources)
    }
    
}
