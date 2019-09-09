//
//  Result.swift
//  cv
//
//  Created by Ireneusz Solek on 09/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import Foundation

enum Result<T>{
  case success(T)
  case error(Error)
}
