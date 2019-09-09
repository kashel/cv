//
//  DataProvider.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

protocol DataProviderFactory {
  var dataProvider: DataProvider { get }
}

protocol DataProvider {
  typealias LoadCompleted = (Result<CurriculumVitae>) -> ()
  func loadCV(completed: @escaping LoadCompleted)
}
