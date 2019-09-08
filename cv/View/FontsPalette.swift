//
//  FontsPalette.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

protocol FontsPaletteFactory {
  var fonts: FontsPalette { get }
}

protocol FontsPalette {
  var cellTitle: UIFont { get }
  var cellValue: UIFont { get }
  var overviewSection: UIFont { get }
  var overviewTitle: UIFont { get }
}

struct DefaultFontsPalette: FontsPalette {
  var cellTitle: UIFont {
    return UIFont(name: "Lato-Bold", size: 12) ?? UIFont.boldSystemFont(ofSize: 12)
  }
  
  var cellValue: UIFont {
    return UIFont(name: "Lato-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
  }
  
  var overviewSection: UIFont {
    return UIFont(name: "Lato-Regular", size: 12) ?? UIFont.systemFont(ofSize: 12)
  }
  
  var overviewTitle: UIFont {
    return UIFont(name: "Lato-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16)
  }
}
