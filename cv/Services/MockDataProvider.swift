//
//  MockDataProvider.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

class MockDataProvider: DataProvider {
  private let mockedData: CurriculumVitae
  
  init(mockedData: CurriculumVitae) {
    self.mockedData = mockedData
  }
  
  func load(completed: (CurriculumVitae) -> ()) {
    completed(mockedData)
  }
}
