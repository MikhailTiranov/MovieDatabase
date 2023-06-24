//
//  MovieCell.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import UIKit

class MovieCell: UICollectionViewCell {
  
  // MARK: - Private (Properties)
  private lazy var infoView: MovieCellInfoView = {
    let view = MovieCellInfoView()
    view.backgroundColor = .infoViewBackground
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var activityIndicator = {
    let view = UIActivityIndicatorView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var imageView: UIImageView = {
    let view = UIImageView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  // MARK: - UICollectionViewCell
  override func prepareForReuse() {
    imageView.image = nil
  }
  
  // MARK: - Init
  init() {
    super.init(frame: CGRect.zero)
    setupView()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  // MARK: - Public (Interface)
  func fetchImage(
    for movie: Movie
  ) {
//    cell.posterImage.image = nil
//
//    if let imageFromCache = imageCache.object(forKey: movie.images!.posterPath as AnyObject) as? UIImage {
//      cell.posterImage.image = imageFromCache
//      cell.activityIndicator.stopAnimating()
//    } else {
//      ImageRepository.shared.fetchImage(imagePath: movie.images!.posterPath, successHandler: { (response) in
//        DispatchQueue.main.async {
//
//          if movie.title == cell.titleLabel.text {
//            cell.posterImage.image = response
//            cell.activityIndicator.stopAnimating()
//          }
//        }
//
//        imageCache.setObject(response, forKey: movie.images!.posterPath as AnyObject)
//      }, errorHandler: {
//        (error) in
//      })
//    }
  }
  
  func configure(for movie: Movie) {
    activityIndicator.startAnimating()
    activityIndicator.hidesWhenStopped = true
    
    infoView.configure(for: movie)
  }
  
  func makeRuntime(runtime: String) -> String {
      let numbers = NSString(string: runtime).intValue
      let hours = numbers / 60
      let minutes = numbers % 60
      let correctTime = String(hours) + "h " + String(minutes) + "min"
      return correctTime
  }
  
  // MARK: - Private (Interface)
  private func setupView() {
    translatesAutoresizingMaskIntoConstraints = false
    
    setupSubviews()
    setupLayout()
  }
  
  private func setupSubviews() {
    addSubview(imageView)
    imageView.addSubview(infoView)
    imageView.addSubview(activityIndicator)
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate(
      [
        bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
        topAnchor.constraint(equalTo: imageView.topAnchor),
        leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
        trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
        
        imageView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor),
        imageView.trailingAnchor.constraint(equalTo: infoView.trailingAnchor),
        imageView.bottomAnchor.constraint(equalTo: infoView.bottomAnchor),
        infoView.heightAnchor.constraint(equalToConstant: MovieCell.infoViewHeight),
        
        activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
        activityIndicator.centerYAnchor.constraint(
          equalTo: imageView.centerYAnchor,
          constant: -20.0
        ),
      ]
    )
  }
}

extension MovieCell {
  private static let infoViewHeight = 95.0
  static let reuseIdentifier = "MovieCell"
}
