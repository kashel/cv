//
//  TitleValueRowBuilder.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

struct TitleValueRowConfigOptions: OptionSet {
  let rawValue: Int
  static let hasTitle = TitleValueRowConfigOptions(rawValue: 1 << 0)
  static let hasValue = TitleValueRowConfigOptions(rawValue: 1 << 1)
}

class TitleValueRowBuilder {
  typealias Factory = ViewComponentsFactory.Factory
  var cellOptions: TitleValueRowConfigOptions = []
  var titleText: String?
  private let components: ViewComponentsFactory
  
  init(factory: Factory) {
    self.components = ViewComponentsFactory(factory: factory)
  }
  
  func addTitle(titleText: String) -> Self {
    self.titleText = titleText
    cellOptions.insert(.hasTitle)
    return self
  }
  
  func addValue() -> Self {
    cellOptions.insert(.hasValue)
    return self
  }
  
  func build() -> TitleValueCellRow {
    let stack = components.stackView
    var titleLabel: UILabel? = nil
    if cellOptions.contains(.hasTitle) {
      let title = components.title
      titleLabel = title
      titleLabel?.text = titleText
      stack.addArrangedSubview(title)
    } else {
      stack.addArrangedSubview(UIView())
    }
    
    var valueLabel: UILabel? = nil
    if cellOptions.contains(.hasValue) {
      let value = components.value
      valueLabel = value
      stack.addArrangedSubview(value)
    }
    let row = TitleValueCellRow(value: valueLabel)
    row.addSubview(stack)
    stack.pinEdges(to: row)
    titleLabel?.widthAnchor.constraint(equalTo: row.widthAnchor, multiplier: 0.35).isActive = true
    return row
  }
  
  struct ViewComponentsFactory {
    typealias Factory = FontsPaletteFactory
    private let fonts: FontsPalette
    
    init(factory: Factory) {
      self.fonts = factory.fonts
    }
    
    var stackView: UIStackView {
      let stack = UIStackView()
      stack.spacing = 16
      return stack
    }
    
    var title: UILabel {
      let label = UILabel()
      label.font = fonts.cellTitle
      label.textColor = .gray
      label.textAlignment = .right
      return label
    }
    
    var value: UILabel {
      let label = UILabel()
      label.font = fonts.cellValue
      label.textColor = .gray
      label.textAlignment = .left
      label.numberOfLines = 0
      return label
    }
    
    var spacer: UIView {
      let view = UIView()
      view.setContentHuggingPriority(.defaultLow, for: .horizontal)
      return view
    }
  }
}
