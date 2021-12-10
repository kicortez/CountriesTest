//
//  HomeController.swift
//  ContriesTest
//
//  Created by Kim Isle Cortez on 12/10/21.
//

import UIKit
import Combine


enum HomeControllerCollectionDataWrapper: Hashable {
	case country(country: Country)
}

// MARK: - Diffable data source
internal typealias HomeControllerCollectionDataSource = UICollectionViewDiffableDataSource<Int, HomeControllerCollectionDataWrapper>
internal typealias HomeControllerCollectionSnapshot = NSDiffableDataSourceSnapshot<Int, HomeControllerCollectionDataWrapper>

class HomeController: UIViewController {
	
	private let searchController = UISearchController(searchResultsController: nil)
	
	private lazy var dataSource: HomeControllerCollectionDataSource = makeDataSource()

	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
		
		collectionView.register(cell: CountryCollectionCell.self)
		
		return collectionView
	}()
	
	private let countryViewModel: CountryViewModel = CountryViewModel()
	
	private var cancellables: Set<AnyCancellable> = Set()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
		setupSubscribers()
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
	
	private func setupSubscribers() {
		// Search subscriber
		NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
			.map({
				($0.object as! UISearchTextField).text!
			})
			.debounce(for: .milliseconds(300), scheduler: RunLoop.main, options: nil)
			.removeDuplicates()
			.sink { [weak self] in
				self?.countryViewModel.searchCountry($0)
			}
			.store(in: &cancellables)
		
		// View model subscriber
		countryViewModel
			.$countrySearchResults
			.sink { [weak self] countries in
				self?.applySnapshot(data: countries)
			}
			.store(in: &cancellables)
	}
	
	// NOTE: Need to update this if UI changes
	private func applySnapshot(data: [HomeControllerCollectionDataWrapper]) {
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
			
			switch itemIdentifier {
			case .country(let country):
				if let cell = cell as? CountryCollectionCell {
					let countryName = "\(String(unicodeScalarLiteral: country.flag)) \(country.officialName)"
					cell.configure(with: countryName)
				}
			}
			
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
