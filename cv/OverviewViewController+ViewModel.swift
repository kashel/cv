//
//  OverviewViewController+ViewModel.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

extension OverviewViewController {
  struct ViewModel {
    typealias Subsection = (title: String, value: String)
    struct Section {
      let title: String
      let details: [Subsection]
    }
    
    let sections: [Section]
  }
}
