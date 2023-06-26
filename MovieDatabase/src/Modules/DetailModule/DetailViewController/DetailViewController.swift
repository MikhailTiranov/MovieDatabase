//
//  DetailViewController.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 23.06.2023.
//

import UIKit

final class DetailViewController: UIViewController {
  
  // MARK: - DetailViewInterface
  var presenter: DetailPresenterInterface! {
    willSet {
      newValue?.viewInterface = self
    }
  }
  
  // MARK: - Private (Properties)
  private lazy var timeLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.textAlignment = .center
    view.font = .systemFont(ofSize: 12.0, weight: .semibold)
    view.textColor = .primaryText
    return view
  }()
  
  private lazy var ratingLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.textAlignment = .center
    view.font = .systemFont(ofSize: 13.0, weight: .thin)
    view.textColor = .accentSecondary
    return view
  }()
  
  private lazy var titleLabel: UILabel = {
    let view = UILabel()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.textAlignment = .center
    view.font = .systemFont(ofSize: 22.0, weight: .medium)
    view.textColor = .accent
    return view
  }()
  
  private lazy var imageView: UIImageView = {
    let view = UIImageView()
    view.tintColor = .accent
    view.backgroundColor = .imageDisabled
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var activityIndicator = {
    let view = UIActivityIndicatorView()
    view.hidesWhenStopped = true
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var genreView: DetailViewTemplateLabel = {
    let view = DetailViewTemplateLabel(with: "Genre")
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var releaseDateView = {
    let view = DetailViewTemplateLabel(with: "Release Date")
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var pointView: PointView = {
    let view = PointView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private lazy var plotLabel: UITextView = {
    let view = UITextView()
    view.isEditable = false
    view.backgroundColor = .background
    view.font = .systemFont(ofSize: 13.0, weight: .medium)
    view.textColor = .primaryText
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  // MARK: - Init
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - ViewController
  override func loadView() {
    view = DetailViewForm()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    presenter.handleOnViewLoad()
  }
  
  private func setupView() {
    setupSubviews()
    setupLayout()
  }
  
  private func setupSubviews() {
    view.addSubview(timeLabel)
    view.addSubview(ratingLabel)
    view.addSubview(titleLabel)
    view.addSubview(imageView)
    
    view.addSubview(activityIndicator)
    
    view.addSubview(genreView)
    view.addSubview(releaseDateView)
    view.addSubview(pointView)
    view.addSubview(plotLabel)
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate(
      [
        timeLabel.topAnchor.constraint(equalTo: view.topAnchor),
        timeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        timeLabel.heightAnchor.constraint(equalToConstant: 70.0),
        timeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),

        ratingLabel.topAnchor.constraint(equalTo: view.topAnchor),
        ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ratingLabel.heightAnchor.constraint(equalToConstant: 70.0),
        ratingLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
        
        titleLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor),
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30.0),
        
        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.0),
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 281/500),
        
        activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
        activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        
        genreView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25.0),
        genreView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        genreView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        genreView.heightAnchor.constraint(equalToConstant: 20.0),
        
        releaseDateView.topAnchor.constraint(equalTo: genreView.bottomAnchor, constant: 15.0),
        releaseDateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        releaseDateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        releaseDateView.heightAnchor.constraint(equalToConstant: 20.0),

        pointView.topAnchor.constraint(equalTo: releaseDateView.bottomAnchor, constant: 10.0),
        pointView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        pointView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        pointView.heightAnchor.constraint(equalToConstant: 5.0),
        
        plotLabel.topAnchor.constraint(equalTo: pointView.bottomAnchor, constant: 5.0),
        plotLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15.0),
        plotLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15.0),
        plotLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ]
    )
  }
}

extension DetailViewController: DetailViewInterface {
  func updateImage(_ image: UIImage?) {
    DispatchQueue.main.async {
      self.activityIndicator.stopAnimating()
      self.imageView.contentMode = image == nil ? .scaleAspectFit : .scaleToFill
      self.imageView.image = image ?? .imageError
    }
  }
  
  func updateMovie(_ movie: MovieDetailRepresentable?) {
    guard let movie else { return }
    
    timeLabel.text = movie.minutesDuration
    
    ratingLabel.text = movie.starsReview

    titleLabel.text = movie.title
    
    imageView.image = nil
    activityIndicator.startAnimating()
        
    genreView.subtitle = movie.allGenres ?? "-"
    
    releaseDateView.subtitle = movie.fullReleaseDate ?? "-"
    
    plotLabel.text = movie.overview
  }
}
