//
//  NetworkDataProvider.swift
//  cv
//
//  Created by Ireneusz Solek on 09/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

class NetworkDataProvider: DataProvider {
  private let networkService: NetworkService
  private let urls: URLPalette
  
  init(networkService: NetworkService, urls: URLPalette) {
    self.networkService = networkService
    self.urls = urls
  }
  
  func loadCV(completed: @escaping (Result<CurriculumVitae>) -> ()) {
    networkService.get(url: urls.cv, result: completed)
  }
}
