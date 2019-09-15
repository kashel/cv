//
//  MockDataProvider.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

final class MockDataProvider: DataProvider {
  private let mockedData: CurriculumVitae
  
  init(mockedData: CurriculumVitae) {
    self.mockedData = mockedData
  }
  
  func loadCV(completed: @escaping (Result<CurriculumVitae>) -> ()) {
    completed(.success(mockedData))
  }
}

