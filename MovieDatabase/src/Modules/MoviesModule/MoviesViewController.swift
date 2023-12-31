//
//  MoviesViewController.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import UIKit

final class MoviesViewController: UICollectionViewController, MoviesViewInterface {
  
  // MARK: - MoviesViewInterface
  var presenter: MoviesPresenterInterface! {
    willSet {
      newValue?.viewInterface = self
    }
  }
  
  // MARK: - Private (Properties)
  private lazy var slideInTransitioningDelegate = SlideInPresentationLayer()
  
  // MARK: - Init
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - UIViewController
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    setupCollectionView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presenter.fetchMovies {
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }
  
  // MARK: - UICollectionViewDataSource
  override func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int { presenter.movies.count }
  
  override func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: MovieCell.reuseIdentifier,
      for: indexPath
    ) as! MovieCell
    
    if let movie = presenter.movies[safe: indexPath.row] {
      cell.configure(for: movie)
    }
    
    return cell
  }
  
  override func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    guard let movie = presenter.movies[safe: indexPath.row] else { return }
    showDetailViewController(with: movie)
  }
  
  // MARK: - Private (Interface)
  private func setupCollectionView() {
    collectionView.backgroundColor = .background
    
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.showsVerticalScrollIndicator = false
    collectionView.contentInsetAdjustmentBehavior = .always
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(
      MovieCell.self,
      forCellWithReuseIdentifier: MovieCell.reuseIdentifier
    )
  }
  
  private func setupNavigationBar() {
    navigationItem.title = "Movie DataBase"
    
    let leftButton = UIBarButtonItem(
      image: .person,
      style: .done,
      target: self,
      action: #selector(personButtonWasTapped)
    )
    
    leftButton.tintColor = .accent
    
    navigationItem.leftBarButtonItem = leftButton
    
    let rightButton = UIBarButtonItem(
      image: .magnifyingglass,
      style: .done,
      target: self,
      action: #selector(searchButtonWasTapped)
    )
    
    rightButton.tintColor = .accent
    
    navigationItem.rightBarButtonItem = rightButton
  }
  
  @objc private func personButtonWasTapped() {
    let viewController = ProfileViewController()
    show(viewController: viewController, from: .left)
  }
  
  @objc private func searchButtonWasTapped() {
    let viewController = UINavigationController(rootViewController: SearchViewContoller()) 
    show(viewController: viewController, from: .right)
  }
  
  private func show(
    viewController: UIViewController,
    from direction: PresentationDirection
  ) {
    slideInTransitioningDelegate.direction = direction
    viewController.transitioningDelegate = slideInTransitioningDelegate
    viewController.modalPresentationStyle = .custom
    present(viewController, animated: true)
  }
  
  private func showDetailViewController(with movie: MovieDetailRepresentable) {
    let presenter = DetailPresenter(with: movie)
    let viewController = DetailViewController()
    viewController.presenter = presenter
    present(viewController, animated: true)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MoviesViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout:
    UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets { .zero }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout:
    UICollectionViewLayout,
    minimumLineSpacingForSectionAt section: Int
  ) -> CGFloat { .zero }
  
  func collectionView(
    _ collectionView:
    UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    minimumInteritemSpacingForSectionAt section: Int
  ) -> CGFloat { .zero }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let width = collectionView.frame.size.width / 2
    return CGSize(width: width, height: width * 1.5)
  }
  
  override func viewWillTransition(
    to size: CGSize,
    with coordinator: UIViewControllerTransitionCoordinator
  ) {
    collectionView?.collectionViewLayout.invalidateLayout()
    super.viewWillTransition(to: size, with: coordinator)
  }
}
