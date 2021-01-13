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
    let urlString = "https://gist.githubusercontent.com/kashel/ef08a9f88d78e46d4caa53f63de4f976/raw/a406f6b90fe5930fb725bbe0eddb4b1f9b1ddc35/Ireneusz_solek_2021"
    guard let url = URL(string: urlString) else {
      fatalError("Failed to construct url for network resource")
    }
    return url
  }
}
