//
//  ListViewController.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit

class ListViewController: UIViewController {
    
    private let ui: ListUI = ListUI()
    private var viewModel: ListViewModel
    
    public static func create(viewModel: ListViewModel, embededInNav: Bool = true) -> UIViewController {
        let listView = ListViewController(with: viewModel)
        guard embededInNav else { return listView }
        listView.title = StringKey.Generic.ListTabName.get()
        return UINavigationController(rootViewController: listView)
    }
    
    init(with viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui.layout(in: self)
        ui.activityIndicatorView.isHidden = false
        viewModel.load(with: self)
    }
}

//MARK: ViewModel Delegates
extension ListViewController: SIXTViewModelDelegate {
    
    func onSIXTViewModelReady(_ viewModel: SIXTViewModel) {
        //configure ui
        ui.activityIndicatorView.isHidden = true
        ui.tableView.dataSource = self
        ui.tableView.reloadData()
    }
    func onSIXTViewModelError(_ viewModel: SIXTViewModel, error: NetworkError) {
        //throw wrror
    }
}

//MARK: TableView DataSource
extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfCars()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ListCell = tableView.dequeue(for: indexPath)
        guard let car = viewModel.getCar(at: indexPath.row) else { return cell }
        cell.configure(with: car)
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
