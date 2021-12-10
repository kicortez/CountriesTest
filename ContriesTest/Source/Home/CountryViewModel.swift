//
//  CountryViewModel.swift
//  ContriesTest
//
//  Created by Kim Isle Cortez on 12/10/21.
//

import Foundation
import Combine

class CountryViewModel {
	
	@Published var country: Country?
	@Published var countrySearchResults: [Country] = []
	
	private var cancellables: Set<AnyCancellable> = Set()
	
	private var countryManager: CountryManager!
	
	init(countryManager: CountryManager = CountryManager()) {
		self.countryManager = countryManager
	}
	
	func searchCountry(_ keyword: String) {
		countryManager.searchCountry(keyword: keyword)
			.map({
				return (try? $0.get()) ?? []
			})
			.sink { [weak self] result in
				self?.countrySearchResults = result
			}
			.store(in: &cancellables)
	}
	
}
