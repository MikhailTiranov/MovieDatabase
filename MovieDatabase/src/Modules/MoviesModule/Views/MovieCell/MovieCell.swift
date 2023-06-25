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
    view.hidesWhenStopped = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var imageView: UIImageView = {
    let view = UIImageView()
    view.tintColor = .accent
    view.backgroundColor = .imageDisabled
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  // TODO: Make cache outside
  private static let imageCache = NSCache<AnyObject, AnyObject>()
  
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
  func configure(for movie: Movie) {
    infoView.configure(for: movie)
    fetchImage(for: movie.posterPath)
  }
  
  // MARK: - Private (Interface)
  private func fetchImage(
    for path: String
  ) {
    imageView.image = nil
    activityIndicator.startAnimating()

    // TODO: start to load only after appearing on screen
    if
      let imageFromCache = Self.imageCache.object(forKey: path as AnyObject) as? UIImage
    {
      imageView.image = imageFromCache
      activityIndicator.stopAnimating()
    } else {
      TMDBService.shared.fetchImage(path: path) { image in
        DispatchQueue.main.async {
          self.activityIndicator.stopAnimating()
          self.setupImage(image)
        }
        Self.imageCache.setObject(image, forKey: path as AnyObject)
      } errorHandler: { error in
        self.setupImage(nil)
      }
    }
  }
  
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
  
  private func setupImage(_ image: UIImage?) {
    imageView.contentMode = image == nil ? .scaleAspectFit : .scaleToFill
    imageView.image = image ?? .imageError
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
