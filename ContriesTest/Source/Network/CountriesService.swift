//
//  CountriesService.swift
//  CountriesTest
//
//  Created by Kim Isle Cortez on 12/10/21.
//

import Foundation

// MARK: - Countries
enum CountriesService: APIService {
	
	case searchCountry(keyword: String)
	
	var path: String {
		switch self {
		case .searchCountry(let keyword):
			if let urlAllowedKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
				return "/name/\(urlAllowedKeyword)"
			}
			return "name/"
		}
	}
	
	var method: String {
		switch self {
		default:
			return "get"
		}
	}
	
	var parameters: [String : Any]? {
		switch self {
		default:
			return nil
		}
	}
	
	var header: [String : String]? {
		switch self {
		default:
			return nil
		}
	}
}

// MARK: - Add more services
