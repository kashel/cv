//
//  View+AutoLayout.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

enum Edge {
  case left
  case right
  case top
  case bottom
}

enum Axis {
  case x
  case y
}

extension UIView {
  private func edgeXContraint(of view: UIView, edge: Edge) -> NSLayoutXAxisAnchor? {
    switch edge {
    case .left:
      return view.leadingAnchor
    case .right:
      return view.trailingAnchor
    default:
      return nil
    }
  }
  
  private func edgeYContraint(of view: UIView, edge: Edge) -> NSLayoutYAxisAnchor? {
    switch edge {
    case .top:
      return view.topAnchor
    case .bottom:
      return view.bottomAnchor
    default:
      return nil
    }
  }
  
  func center(with other: UIView, axis: Axis? = nil) {
    if let axis = axis, axis == .x {
      centerXAnchor.constraint(equalTo: other.centerXAnchor).isActive = true
      return
    }
    if let axis = axis, axis == .y {
      centerYAnchor.constraint(equalTo: other.centerYAnchor).isActive = true
      return
    }
    centerXAnchor.constraint(equalTo: other.centerXAnchor).isActive = true
    centerYAnchor.constraint(equalTo: other.centerYAnchor).isActive = true
  }
  
  func pinEdge(_ ownEdge: Edge, to other: UIView, edge otherEdge: Edge, offset: CGFloat = 0) {
    self.translatesAutoresizingMaskIntoConstraints = false
    var constraint: NSLayoutConstraint? = nil
    if let ownEdgeAnchor = edgeXContraint(of: self, edge: ownEdge),
      let otherEdgeAnchor = edgeXContraint(of: other, edge: otherEdge) {
      constraint = ownEdgeAnchor.constraint(equalTo: otherEdgeAnchor)
    } else if let ownEdgeAnchor = edgeYContraint(of: self, edge: ownEdge),
      let otherEdgeAnchor = edgeYContraint(of: other, edge: otherEdge) {
      constraint = ownEdgeAnchor.constraint(equalTo: otherEdgeAnchor)
    } else {
      assertionFailure("Edges must match coordication")
    }
    constraint?.constant = offset
    constraint?.isActive = true
  }
  
  func pinEdges(to other: UIView, offsets: UIEdgeInsets = .zero, edges: UIRectEdge = .all) {
    self.translatesAutoresizingMaskIntoConstraints = false
    if edges.contains(.left) || edges.contains(.all) {
      let leading = leadingAnchor.constraint(equalTo: other.leadingAnchor)
      leading.constant = offsets.left
      leading.isActive = true
    }
    if edges.contains(.right) || edges.contains(.all) {
      let trailing = trailingAnchor.constraint(equalTo: other.trailingAnchor)
      trailing.constant = offsets.right
      trailing.isActive = true
    }
    if edges.contains(.top) || edges.contains(.all) {
      let top = topAnchor.constraint(equalTo: other.topAnchor)
      top.constant = offsets.top
      top.isActive = true
    }
    if edges.contains(.bottom) || edges.contains(.all) {
      let bottom = bottomAnchor.constraint(equalTo: other.bottomAnchor)
      bottom.constant = offsets.bottom
      bottom.isActive = true
    }
  }
  
  func pinToSafeArea(of other: UIView, offsets: UIEdgeInsets = .zero, edges: UIRectEdge = .all) {
    self.translatesAutoresizingMaskIntoConstraints = false
    if edges.contains(.left) || edges.contains(.all) {
      let constraint = leadingAnchor.constraint(equalTo: other.safeAreaLayoutGuide.leadingAnchor)
      constraint.constant = offsets.left
      constraint.isActive = true
    }
    if edges.contains(.right) || edges.contains(.all) {
      let constraint = trailingAnchor.constraint(equalTo: other.safeAreaLayoutGuide.trailingAnchor)
      constraint.constant = offsets.right
      constraint.isActive = true
    }
    if edges.contains(.top) || edges.contains(.all) {
      let constraint = topAnchor.constraint(equalTo: other.safeAreaLayoutGuide.topAnchor)
      constraint.constant = offsets.top
      constraint.isActive = true
    }
    if edges.contains(.bottom) || edges.contains(.all) {
      let constraint = bottomAnchor.constraint(equalTo: other.safeAreaLayoutGuide.bottomAnchor)
      constraint.constant = offsets.bottom
      constraint.isActive = true
    }
  }
}
