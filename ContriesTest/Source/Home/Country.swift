//
//  Country.swift
//  ContriesTest
//
//  Created by Kim Isle Cortez on 12/10/21.
//

import Foundation

struct CountryName {
	let common: String
	let official: String
}

struct Country {
	private let name: CountryName
	
	var officialName: String {
		return name.official
	}
	
	var commonName: String {
		return name.common
	}
}

extension Country: Equatable, Hashable {}
extension Country: Decodable {
	enum CodingKeys: String, CodingKey {
		case name
	}
}

extension CountryName: Decodable, Equatable, Hashable {}
