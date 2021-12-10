//
//  HomeCoordinator.swift
//  ContriesTest
//
//  Created by Kim Isle Cortez on 12/10/21.
//

import Foundation
import UIKit

class HomeCoordinator {
	
	private weak var presenter: UIViewController?
	
	init(presenter: UINavigationController) {
		self.presenter = presenter
	}
	
	func start() {
		let homeController = HomeController()
		
		if let presenter = presenter as? UINavigationController {
			presenter.setViewControllers([homeController], animated: false)
		}
	}
	
}
