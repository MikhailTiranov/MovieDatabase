//
//  DetailViewForm.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 23.06.2023.
//

import UIKit

class DetailViewForm: UIView {
  
  // MARK: - Private (Properties)
  private var path: UIBezierPath!
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // MARK: - UIView
  override func draw(_ rect: CGRect) {
    drawStickerShape()
    UIColor.background.setFill()
    path.fill()
  }
  
  // MARK: - Private (Interface)
  private func drawStickerShape() {
    let height = frame.size.height
    let width = frame.size.width

    path = UIBezierPath()
    
    path.move(to: CGPoint(x: .zero, y: 18.0))
    path.addArc(
      withCenter: .zero,
      radius: 18.0,
      startAngle: CGFloat(270.0).radians,
      endAngle: CGFloat(360.0).radians,
      clockwise: false
    )
    path.addLine(to: CGPoint(x: 18.0, y: .zero))
    path.addLine(to: CGPoint(x: width / 2 - 30.0, y: .zero))
    path.addArc(
      withCenter: CGPoint(x: width / 2, y: .zero),
      radius: 30.0,
      startAngle: CGFloat(180.0).radians,
      endAngle: .zero.radians,
      clockwise: false
    )
    path.addLine(to: CGPoint(x: width / 2 + 30.0, y: .zero))
    path.addLine(to: CGPoint(x: width - 18.0, y: .zero))
    path.addArc(
      withCenter: CGPoint(x: width, y: .zero),
      radius: 18.0,
      startAngle: CGFloat(180.0).radians,
      endAngle: CGFloat(90.0).radians,
      clockwise: false
    )
    path.addLine(to: CGPoint(x: width, y: -18.0))
    
    path.addLine(to: CGPoint(x: width, y: height - 5.0))
    path.addArc(
      withCenter: CGPoint(x: width - 5.0, y: height - 5.0),
      radius: 5.0,
      startAngle: .zero.radians,
      endAngle: CGFloat(90.0).radians,
      clockwise: true
    )
    path.addLine(to: CGPoint(x: width - 5.0, y: height))
    path.addLine(to: CGPoint(x: 5.0, y: height))
    path.addArc(
      withCenter: CGPoint(x: 5.0, y: height - 5.0),
      radius: 5.0,
      startAngle: CGFloat(270.0).radians,
      endAngle: CGFloat(180.0).radians,
      clockwise: true
    )
    path.addLine(to: CGPoint(x: .zero, y: height - 5.0))
    path.close()
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = path.cgPath
    layer.mask = shapeLayer
  }
}
