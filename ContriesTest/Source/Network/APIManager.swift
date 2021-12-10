//
//  APIManager.swift
//  CountriesTest
//
//  Created by Kim Isle Cortez on 12/10/21.
//

import Foundation
import Alamofire
import Combine

/// Basic protocol for sending network requests. Only contains basic properties and functions for simplicity.
protocol APIManagerProtocol {
	static var baseURL: String { get }
	static func request<T: Decodable>(_ service: APIService) -> AnyPublisher<Result<T, Error>, Never>
}

/// This implementation wraps Alamofire usage. Should Alamofire be removed, update only this implementation without affecting actual API calls in the app.
class AFAPIManager: APIManagerProtocol {
	
	internal static var baseURL: String {
		return "https://restcountries.com/v3.1"
	}
	
	static func request<T: Decodable>(_ service: APIService) -> AnyPublisher<Result<T, Error>, Never> {
		let url = baseURL.appending(service.path)
		let method = HTTPMethod(rawValue: service.method)
		var afHeaders: HTTPHeaders?
		
		if let headers = service.header {
			afHeaders = HTTPHeaders(headers)
		}
		
		return AF.request(url, method: method, parameters: service.parameters, headers: afHeaders, interceptor: nil, requestModifier: nil)
			.publishDecodable(type: T.self)
			.map({ $0.result.mapError({ $0 }) })
			.eraseToAnyPublisher()
	}
	
}
