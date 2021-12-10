//
//  UIView+Extensions.swift
//  ContriesTest
//
//  Created by Kim Isle Cortez on 12/10/21.
//

import Foundation
import UIKit

extension UIView {
	
	func pin(_ view: UIView) {
		NSLayoutConstraint.activate([
			view.topAnchor.constraint(equalTo: self.topAnchor),
			view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
			self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
	}
	
}
