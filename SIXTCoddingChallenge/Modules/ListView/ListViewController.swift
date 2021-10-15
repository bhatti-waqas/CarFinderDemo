//
//  ListViewController.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit

class ListViewController: UIViewController {
    
    private let ui: ListUI = ListUI()
    
    public static func create(embededInNav: Bool = true) -> UIViewController {
        let listView = ListViewController()
        guard embededInNav else { return listView }
        return UINavigationController(rootViewController: listView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.layout(in: self)
        ui.tableView.dataSource = self
    }
}

//MARK: TableView DataSource

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListCell = tableView.dequeue(for: indexPath)
        cell.titleLabel.text = "Hello bhatti"
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
