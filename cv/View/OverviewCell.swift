//
//  OverviewCell.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

class OverviewCell: UITableViewCell {
  private var rows: [TitleValueCellRow] = []
  private var isSetupFinished: Bool = false
  typealias Factory = ViewComponentsFactory.Factory

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureWithViewModel(_ viewModel: ViewModel, factory: Factory) {
    setupIfNeeded(viewModel: viewModel, factory: factory)
    for (index, rowViewModel) in viewModel.rows.enumerated() {
      rows[index].configure(value: rowViewModel.value)
    }
  }
  
  func setupIfNeeded(viewModel: ViewModel, factory: Factory) {
    selectionStyle = .none
    guard !isSetupFinished else {
      return
    }
    let components = ViewComponentsFactory(factory: factory)
    rows = components.rowsWithViewModel(viewModel)
    let stack = components.stackViewWithArrangedSubviews(rows)
    addSubview(stack)
    stack.pinEdges(to: self, offsets: components.cellOffsets)
    if viewModel.hasDetails {
      self.accessoryType = .disclosureIndicator
    }
  }
}
