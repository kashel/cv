//
//  URLPanel.swift
//  cv
//
//  Created by Ireneusz Solek on 09/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

protocol URLPanelFactory {
  var urls: URLPanel { get }
}

protocol URLPanel {
  var cv: URL { get }
}

struct NetworkURLPanel: URLPanel {
  var cv: URL {
    let urlString = "https://gist.githubusercontent.com/kashel/5432d1b6de5b387a0be6ce21fb7359dc/raw/095dbb0952d74f2f28d760f65fe0b11aea33707f/gistfile1.txt"
    guard let url = URL(string: urlString) else {
      fatalError("Failed to construct url for network resource")
    }
    return url
  }
}
