//
//  OverviewCell+ViewModel.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

extension OverviewCell {
  struct ViewModel {
    struct Row {
      let title: String
      let value: String
      let accessibilityIdentifier: String
    }
    let hasDetails: Bool
    let rows: [Row]
  }
}
