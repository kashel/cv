//
//  OverviewViewController+UITableViewDataSource.swift
//  cv
//
//  Created by Ireneusz Solek on 15/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

extension OverviewViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel?.sections.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let rows = viewModel?.sections[section].details.count ?? 0
    return rows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let section = SectionOrder(rawValue: indexPath.section),
      let cellViewModel = cellViewModelForIndexPath(indexPath) else {
        modelAssertionFailure()
        return UITableViewCell()
    }
    let cell = dequeCellForSection(section)
    cell.configureWithViewModel(cellViewModel, factory: factory)
    return cell
  }
  
  private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 44
  }
  
  private func dequeCellForSection(_ section: SectionOrder) -> OverviewCell {
    return tableView.dequeueReusableCell(withIdentifier: section.reuseIdentifier) as? OverviewCell ?? OverviewCell()
  }
  
  private func cellViewModelForIndexPath(_ indexPath: IndexPath) -> OverviewCell.ViewModel? {
    return viewModel?.sections[indexPath.section].details[indexPath.row]
  }
}
