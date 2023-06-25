//
//  SearchViewContoller.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 25.06.2023.
//

import UIKit

final class SearchViewContoller: UITableViewController {
  
  // MARK: - ViewController
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  // MARK: - Private (Interface)
  private func setupView() {
    view.backgroundColor = .background
  }
}
