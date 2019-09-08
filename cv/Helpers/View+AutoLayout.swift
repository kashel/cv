//
//  View+AutoLayout.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

extension UIView {
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
}
