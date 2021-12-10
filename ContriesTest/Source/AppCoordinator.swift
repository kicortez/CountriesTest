//
//  AppCoordinator.swift
//  ContriesTest
//
//  Created by Kim Isle Cortez on 12/10/21.
//

import Foundation
import UIKit

class AppCoordinator {
	
	private weak var window: UIWindow?
	
	private var homeCoordinator: HomeCoordinator?
	
	init(window: UIWindow) {
		self.window = window
	}
	
	func start() {
		let navigationController = UINavigationController()
		let coordinator = HomeCoordinator(presenter: navigationController)
		coordinator.start()
		homeCoordinator = coordinator
		
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()
	}
	
}
