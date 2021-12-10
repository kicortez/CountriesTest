//
//  HomeController.swift
//  ContriesTest
//
//  Created by Kim Isle Cortez on 12/10/21.
//

import UIKit
import Combine


// MARK: - Diffable data source
internal typealias HomeControllerCollectionDataSource = UICollectionViewDiffableDataSource<Int, Int>
internal typealias HomeControllerCollectionSnapshot = NSDiffableDataSourceSnapshot<Int, Int>

class HomeController: UIViewController {
	
	private let searchController = UISearchController(searchResultsController: nil)
	
	private lazy var dataSource: HomeControllerCollectionDataSource = makeDataSource()

	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
		
		collectionView.register(cell: CountryCollectionCell.self)
		
		return collectionView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
	}
	
	private func setupViews() {
		view.backgroundColor = .white
		
		setupCollectionView()
		setupSearch()
	}
	
	private func setupSearch() {
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.hidesNavigationBarDuringPresentation = false
		searchController.searchBar.placeholder = "Search country"
		
		definesPresentationContext = true
		
		navigationItem.titleView = searchController.searchBar
	}
	
	private func setupCollectionView() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(collectionView)
		view.pin(collectionView)
	}
	
	// NOTE: Need to update this if UI changes
	private func applySnapshot(data: [Int]) {
		var snapshot = HomeControllerCollectionSnapshot()
		
		snapshot.appendSections([1])
		snapshot.appendItems(data)
		
		dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
	}

}

// MARK: - UICollectionView setup
extension HomeController {
	
	private func makeDataSource() -> HomeControllerCollectionDataSource {
		let source = HomeControllerCollectionDataSource(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
			
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCollectionCell.reuseIdentifier, for: indexPath)
			
			return cell
		})
		
		return source
	}
	
	private func makeLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			
			return self.buildArtistsLayout()
		}
		
		return layout
	}
																				 
	// MARK: - Artists Layout
	
	private func buildArtistsLayout() -> NSCollectionLayoutSection? {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
											  heightDimension: .fractionalHeight(1.0))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(58.0))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
		
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = NSDirectionalEdgeInsets(top: 8.0,
														leading: 16.0,
														bottom: 8.0,
														trailing: 16.0)
		section.interGroupSpacing = 8.0
		
		return section
	}
	
}
