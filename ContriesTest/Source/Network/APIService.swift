//
//  APIService.swift
//  CountriesTest
//
//  Created by Kim Isle Cortez on 12/10/21.
//

import Foundation

/// For use to create endpoints for the API. Properties indicate basic HTTP request details
protocol APIService {
	
	var path: String { get }
	var method: String { get }
	var parameters: [String: Any]? { get }
	var header: [String: String]? { get }
	
}
