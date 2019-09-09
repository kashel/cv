//
//  URLPalette.swift
//  cv
//
//  Created by Ireneusz Solek on 09/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

protocol URLPaletteFactory {
  var urls: URLPalette { get }
}

protocol URLPalette {
  var cv: URL { get }
}

struct NetworkURLPalette: URLPalette {
  var cv: URL {
    let urlString = "https://gist.githubusercontent.com/kashel/4819ef997a765919b2484ca675c8c370/raw/0b8f4bcaf93bd94e1c9a1657602b32a9df8ba094/gistfile1.txt"
    guard let url = URL(string: urlString) else {
      fatalError("Failed to construct url for network resource")
    }
    return url
  }
}
