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
  
  init() {
    super.init(style: .default, reuseIdentifier: "")
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configureWithViewModel(_ viewModel: ViewModel) {
    setupIfNeeded(viewModel: viewModel)
    for (index, rowViewModel) in viewModel.rows.enumerated() {
      rows[index].configure(value: rowViewModel.value)
    }
  }
  
  func setupIfNeeded(viewModel: ViewModel) {
    guard !isSetupFinished else {
      return
    }
    let components = ViewComponentsFactory()
    rows = components.rowsWithViewModel(viewModel)
    let stack = components.stackViewWithArrangedSubviews(rows)
    addSubview(stack)
    stack.pinEdges(to: self, offsets: components.cellOffsets)
    if viewModel.hasDetails {
      self.accessoryType = .disclosureIndicator
    }
  }
}
