//
//  ViewController.swift
//  cv
//
//  Created by Ireneusz Solek on 08/09/2019.
//  Copyright © 2019 Ireneusz Solek. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {
  typealias Factory = DataProviderFactory & OverviewViewModelMapperFactory
  
  private let tableView: UITableView
  private let dataProvider: DataProvider
  private let overviewViewModelMapper: OverviewViewModelMapper
  
  init(factory: Factory) {
    self.tableView = UITableView()
    self.dataProvider = factory.dataProvider
    self.overviewViewModelMapper = factory.overviewViewModelMapper
    super.init(nibName: nil, bundle: nil)
    tableView.dataSource = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension OverviewViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return UITableViewCell()
  }
}
