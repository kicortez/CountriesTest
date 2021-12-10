//
//  CountryManager.swift
//  ContriesTest
//
//  Created by Kim Isle Cortez on 12/10/21.
//

import Foundation
import Combine

// DataAccessAPI protocol is mainly used as access data, from any source

protocol CountryDataAccessProtocol: AnyObject {
	func searchCountry(keyword: String) -> AnyPublisher<Result<[Country], Error>, Never>
}

// This class conforms to ArtistDataAccessAPI, and it's implementation accesses artist related content from a server
class CountryDataAccessAPI: CountryDataAccessProtocol {
	
	func searchCountry(keyword: String) -> AnyPublisher<Result<[Country], Error>, Never> {
		return AFAPIManager.request(CountriesService.searchCountry(keyword: keyword))
	}
	
}

class CountryManager {
	
	private var dataAccessor: CountryDataAccessProtocol!
	
	// Allows injection as needed, for instance, if you want to access data from local storage
	init(dataAccessor: CountryDataAccessProtocol = CountryDataAccessAPI()) {
		self.dataAccessor = dataAccessor
	}
	
	func searchCountry(keyword: String) -> AnyPublisher<Result<[Country], Error>, Never> {
		return dataAccessor.searchCountry(keyword: keyword)
	}
	
}
