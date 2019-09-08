//
//  View+AutoLayout.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

extension UIView {
  func pinEdges(to other: UIView) {
    leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
    trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
    topAnchor.constraint(equalTo: other.topAnchor).isActive = true
    bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
  }
}
