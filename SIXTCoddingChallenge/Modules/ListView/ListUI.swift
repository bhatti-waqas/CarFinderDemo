//
//  ListUI.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit
import SnapKit

class ListUI: SIXTBaseUI {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 30
        return tableView
    }()
    
    override func layout(in viewController: UIViewController) {
        super.layout(in: viewController)
        viewController.view.backgroundColor = .white
        viewController.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(50)
            make.bottom.equalToSuperview()
        }
        tableView.register(cell: ListCell.self)
    }
}
