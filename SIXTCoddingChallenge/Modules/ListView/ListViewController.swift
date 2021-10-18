//
//  ListViewController.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit
import Combine

class ListViewController: UIViewController {
    
    private var viewModel: ListViewModel
    private var rootView: ListView
    private lazy var dataSource = makeDataSource()
    private var cancellable: [AnyCancellable] = []
    
    
    init(with viewModel: ListViewModel, rootView: ListView) {
        self.viewModel = viewModel
        self.rootView = rootView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindViewModel()
        viewModel.load()
    }
    
    private func configureUI() {
        rootView.backgroundColor = .white
        rootView.spinner.startAnimating()
        rootView.tableView.refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        rootView.tableView.dataSource = dataSource
    }
    
    private func bindViewModel() {
        viewModel.stateDidUpdate.sink(receiveValue: { [unowned self] state in
            self.render(_state: state)
        }).store(in: &cancellable)
    }
    
    private func render(_state: ListViewModelState) {
        switch _state {
        case .show(let cars):
            self.showList(with: cars)
        case .error(let error):
            handleError(with: error)
        }
    }
    
    private func showList(with cars: [ListCellViewModel]) {
        rootView.tableView.refreshControl?.endRefreshing()
        rootView.spinner.stopAnimating()
        self.update(with: cars)
    }
    
    private func handleError(with error: NetworkError) {
        rootView.tableView.refreshControl?.endRefreshing()
        rootView.spinner.stopAnimating()
        AlertHandler.showError(self, error: error)
    }
    
    @objc private func refreshList() {
        viewModel.load()
    }
}

//MARK: Diffacble Datasource
fileprivate extension ListViewController {
    enum Section: CaseIterable {
        case cars
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Section, ListCellViewModel> {
        return UITableViewDiffableDataSource(
            tableView: rootView.tableView,
            cellProvider: {  tableView, indexPath, listCellViewModel in
                let cell: ListCell = self.rootView.tableView.dequeue(for: indexPath)
                cell.configure(with: listCellViewModel)
                return cell
            })
    }
    
    private func update(with cars: [ListCellViewModel], animate: Bool = false) {
        Run.onMainThread {
            var snapshot = NSDiffableDataSourceSnapshot<Section, ListCellViewModel>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(cars, toSection: .cars)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}
