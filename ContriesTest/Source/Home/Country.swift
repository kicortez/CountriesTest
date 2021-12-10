//
//  Country.swift
//  ContriesTest
//
//  Created by Kim Isle Cortez on 12/10/21.
//

import Foundation

struct CountryName: Decodable {
	let common: String
	let official: String
}

struct Country: Decodable {
	private let name: CountryName
	
	var officialName: String {
		return name.official
	}
	
	var commonName: String {
		return name.common
	}
	
	enum CodingKeys: String, CodingKey {
		case name
	}
}
