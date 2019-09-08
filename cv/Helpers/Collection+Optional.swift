//
//  Collection+Safe.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

extension Collection {
  subscript(optional i: Index) -> Iterator.Element? {
    return self.indices.contains(i) ? self[i] : nil
  }
}
