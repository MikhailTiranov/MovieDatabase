//
//  SearchViewContoller.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 25.06.2023.
//

import UIKit

class SearchViewContoller: UITableViewController {
  
  // MARK: - Private (Properties)
  private var searchedMovies = [Movie]()
  private var searchController = UISearchController(searchResultsController: nil)
  
  private static let reuseIdentifier = "MovieSearchCell"
  
  // MARK: - UIViewController Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  // TODO: ADD PAGINATION
  
  // MARK: - UITableViewDateSource
  override func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int { searchedMovies.count }
  
  override func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: Self.reuseIdentifier,
      for: indexPath
    )
        
    cell.backgroundColor = .background
    cell.textLabel?.text = searchedMovies[safe: indexPath.row]?.title
    
    return cell
  }
  
  override func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    guard let movie = searchedMovies[safe: indexPath.row] else { return }
    showDetailViewController(with: movie)
  }
  
  // MARK: - Private (Interface)
  private func setupView() {
    setupAppearence()
    setupTableView()
    setupSearchController()
  }
  
  private func setupAppearence() {
    view.backgroundColor = .background
    tableView.backgroundColor = .background
    
    navigationItem.titleView = searchController.searchBar
    definesPresentationContext = true
  }
  
  private func setupTableView() {
    tableView.register(
      UITableViewCell.self,
      forCellReuseIdentifier: Self.reuseIdentifier
    )
  }
  
  private func setupSearchController() {
    searchController.searchBar.delegate = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search"
    searchController.searchBar.tintColor = .primaryText
    
    searchController.hidesNavigationBarDuringPresentation = false
    searchController.searchBar.image(for: .search, state: .disabled)
  }
  
  private func showDetailViewController(with movie: MovieDetailRepresentable) {
    let presenter = DetailPresenter(with: movie)
    let viewController = DetailViewController()
    viewController.presenter = presenter
    present(viewController, animated: true)
  }
}

extension SearchViewContoller: UISearchBarDelegate {
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchedMovies = []
    tableView.reloadData()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchedMovies = []
    
    if let searchText = searchController.searchBar.text {
      TMDBService.shared.searchMovie(with: searchText) { response in
        self.searchedMovies = response
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      } errorHandler: { error in
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
    }
  }
}

//extension SearchViewContoller: UISearchResultsUpdating {
//  func updateSearchResults(
//    for searchController: UISearchController
//  ) {
//    print(Data(), #line, #function)
//  }
//}
