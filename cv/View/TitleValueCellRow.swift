//
//  TitleValueCellRow.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

final class TitleValueCellRow: UIView {
  let value: UILabel?
  
  init(value: UILabel?) {
    self.value = value
    super.init(frame: .zero)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(value: String?, accessibilityIdentifier: String?) {
    self.value?.text = value
    self.value?.accessibilityIdentifier = accessibilityIdentifier
  }
}
