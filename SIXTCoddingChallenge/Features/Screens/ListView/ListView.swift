//
//  ListView.swift
//  SIXTCoddingChallenge
//
//  Created by Waqas Naseem on 10/18/21.
//

import UIKit
import SnapKit

final class ListView: UIView {
    
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 30
        tableView.refreshControl = UIRefreshControl()
        return tableView
    }()
    
    public let activityIndicatorView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    public let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setup() {
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        [tableView, spinner].forEach(addSubview)
        tableView.register(cell: ListCell.self)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(50)
            make.bottom.equalToSuperview()
        }
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
