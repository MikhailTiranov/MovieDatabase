//
//  PointView.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 23.06.2023.
//

import UIKit

class PointView: UIView {
    
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: - UIView
  override func draw(_ rect: CGRect) {
    circlesAdditionShape()
  }
  
  // MARK: - Private (Interface)
  private func circlesAdditionShape() {
    var x: CGFloat = .zero
    
    let shapeLayer = CAShapeLayer()
    let path = UIBezierPath()
    
    repeat {
      path.addArc(
        withCenter: CGPoint(x: x, y: frame.size.height / 2),
        radius: 2.3,
        startAngle: .zero.radians,
        endAngle: CGFloat(360.0).radians,
        clockwise: true
      )
      x += 6.5
    } while x <= frame.size.width
    
    shapeLayer.path = path.cgPath
    shapeLayer.fillColor = UIColor.dotBackground.cgColor
    
    layer.addSublayer(shapeLayer)
  }
}
