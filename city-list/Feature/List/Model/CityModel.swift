//
//  CityModel.swift
//  city-list
//
//  Created by Vahid Ghanbarpour on 7/17/24.
//

import Foundation

/// Data representation `Model` for `City` with its generic dependency `ComparisonResult`
/// deciding which algorithm to use when using as an imput for ``Explorer``
struct CityModel: Decodable, Identifiable {
    
    let country: String
    let city: String
    let id: Int
    let coordinates: Coordinates
    
    struct Coordinates: Decodable {
        let longitude: Double
        let latitude: Double
        
        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CityModel.Coordinates.CodingKeys.self)
            self.longitude = try container.decode(Double.self, forKey: CityModel.Coordinates.CodingKeys.longitude)
            self.latitude = try container.decode(Double.self, forKey: CityModel.Coordinates.CodingKeys.latitude)
        }
        
        /// custom keys for a more readable representation
        enum CodingKeys: String, CodingKey {
            case longitude = "lon"
            case latitude = "lat"
        }
        
        init(
            longitude: Double,
            latitude: Double
        ) {
            self.longitude = longitude
            self.latitude = latitude
        }
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.country = try container.decode(String.self, forKey: .country)
        self.city = try container.decode(String.self, forKey: .city)
        self.id = try container.decode(Int.self, forKey: .id)
        self.coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
    }
    
    /// custom keys for a more readable representation
    enum CodingKeys: String, CodingKey {
        case country = "country"
        case city = "name"
        case id = "_id"
        case coordinates = "coord"
    }
    
    init(
        country: String,
        city: String,
        id: Int,
        coordinates: Coordinates
    ) {
        
        self.country = country
        self.city = city
        self.id = id
        self.coordinates = coordinates
        
    }
}

extension CityModel: CellRepresentable {
    var title: String {
        [city, country].joined(separator: ", ")
    }
    
    var subtitle: String {
        ["lon: \(coordinates.longitude)", "lat: \(coordinates.latitude)"].joined(separator: ", ")
    }
}

extension CityModel: BinaryComparable {
    func direction(against reference: String) -> BinaryComaparison {
        if city.starts(with: reference) {
            return .match
        }
        if city < reference {
            return .left
        }
        return .right
    }
}

extension CityModel: FilterComparable {
    func filter(using reference: Compared) -> Bool {
        city.starts(with: reference)
    }
}

extension CityModel: Comparable {
    typealias Compared = String
    
    static func == (lhs: CityModel, rhs: CityModel) -> Bool {
        lhs.city == rhs.city && lhs.country == rhs.country
    }
    
    static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs.city == rhs.city {
            return lhs.country < rhs.country
        }
        return lhs.city < rhs.city
    }
}
