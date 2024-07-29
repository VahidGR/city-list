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

extension CityModel: DecodableBinaryComparable {
    func direction(against reference: String) -> BinaryComaparison {
        if city.starts(with: reference) {
            return .match
        }
        if city < reference {
            return .left
        }
        return .right
    }
	
	func direction(against reference: String, forKey key: CodingKeys) -> BinaryComaparison {
		switch key {
			case .country:
				country.direction(against: reference)
			case .city:
				city.direction(against: reference)
			case .id:
				id.direction(against: .parse(reference))
			case .coordinates:
				coordinates.direction(against: .parse(reference))
		}
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

extension CityModel: CodedComparable {
	func compare(
		against reference: CityModel,
		withKey key: CodingKeys,
		by areInIncreasingOrder: (CityModel, CityModel) throws -> Bool
	) -> Bool {
		switch key {
			case .country:
				return self.country < reference.country
			case .city:
				return self.city < reference.city
			case .id:
				return self.id < reference.id
			case .coordinates:
				return self.coordinates < reference.coordinates
		}
	}
}

extension Int: BinaryComparable {
	func direction(against reference: Self) -> BinaryComaparison {
		if self >= reference {
			return .match
		}
		return .left
	}
	
	typealias Compared = Self
	
	static func parse(_ text: String) -> Self {
		guard let number = Int(text)
		else {
			fatalError("Format mismatched") // should throw an error with mismathich format
		}
		return number
	}
}

extension String: BinaryComparable {
	typealias Compared = Self
	func direction(against reference: Self) -> BinaryComaparison {
		if self.starts(with: reference) {
			return .match
		}
		if self < reference {
			return .left
		}
		return .right
	}
}

extension CityModel.Coordinates: BinaryComparable {
	func direction(against reference: Self) -> BinaryComaparison {
		let lhs = self
		let rhs = reference
		
		
		
		
		
		if self >= reference {
			return .match
		}
		return .left
		
//		if self == reference {
//			return .match
//		}
//		if self < reference {
//			return .left
//		}
//		return .right
	}
	
	typealias Compared = Self
	
	func distance(to location: Self) -> Double {
		
	}
	
	static func < (lhs: Self, rhs: Self) -> Bool {
		lhs.longitude < rhs.longitude && lhs.latitude < rhs.latitude
	}
	
	static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.longitude == rhs.longitude && lhs.latitude == rhs.latitude
	}
	
	static func parse(_ text: String) -> Self {
		let coords = text.components(separatedBy: ", ").compactMap { Double($0) }
		guard coords.count == 2
		else {
			fatalError("Format mismatched") // should throw an error with mismathich format
		}
		return .init(longitude: coords[0], latitude: coords[1])
	}
}
