//
//  ListViewController.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/14/21.
//

import UIKit
import Combine

class ListViewController: UIViewController {
    
    private var viewModel: CarsListViewModel
    private var rootView: ListView
    private lazy var dataSource = makeDataSource()
    private var cancellables: [AnyCancellable] = []
    private let refresh = PassthroughSubject<Void, Never>()
    
    init(with viewModel: CarsListViewModel, rootView: ListView) {
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh.send(())
    }
    
    private func configureUI() {
        rootView.backgroundColor = .white
        rootView.spinner.startAnimating()
        rootView.tableView.refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        rootView.tableView.dataSource = dataSource
    }
    
    private func bindViewModel() {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        let input = CarsListViewModelInput(refresh: refresh.eraseToAnyPublisher())
        let output = viewModel.transform(input: input)
        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }
    
    private func render(_ state: CarsListState) {
        switch state {
        case .idle:
            update(with: [], animate: false)
        case .loading:
            rootView.spinner.startAnimating()
            update(with: [], animate: false)
        case .noResults:
            rootView.spinner.stopAnimating()
            rootView.tableView.refreshControl?.endRefreshing()
            update(with: [], animate: false)
        case .failure(let errorMessage):
            rootView.spinner.stopAnimating()
            rootView.tableView.refreshControl?.endRefreshing()
            AlertHandler.showAlert(self, message: errorMessage)
        case .success(let cars):
            rootView.spinner.stopAnimating()
            rootView.tableView.refreshControl?.endRefreshing()
            update(with: cars, animate: false)
        }
    }
    
    private func showList(with cars: [CarRowViewModel]) {
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
        refresh.send(())
    }
}

//MARK: Diffacble Datasource
fileprivate extension ListViewController {
    enum Section: CaseIterable {
        case cars
    }
    
    private func makeDataSource() -> UITableViewDiffableDataSource<Section, CarRowViewModel> {
        return UITableViewDiffableDataSource(
            tableView: rootView.tableView,
            cellProvider: {  tableView, indexPath, carRowViewModel in
                let cell: ListCell = self.rootView.tableView.dequeue(for: indexPath)
                cell.configure(with: carRowViewModel)
                return cell
            })
    }
    
    private func update(with cars: [CarRowViewModel], animate: Bool = false) {
        Run.onMainThread {
            var snapshot = NSDiffableDataSourceSnapshot<Section, CarRowViewModel>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(cars, toSection: .cars)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}
