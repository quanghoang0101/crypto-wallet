//
//  FavoriteViewController.swift
//  cryto-wallet
//
//  Created by Hoang on 09/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.className)
        view.dataSource = self
        view.delegate = self
        view.rowHeight = UITableView.automaticDimension
        view.separatorStyle = .none
        return view
    }()

    private var viewModel: CurrencyViewModel

    init(with viewModel: CurrencyViewModel) {
        self.viewModel = viewModel
        self.viewModel.fetchCurrencies()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = R.string.localizable.favorite()

        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { maker in
            maker.leading.trailing.top.bottom.equalToSuperview()
        }

        // MARK: Binding
        viewModel.favorites.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive,
                                        title: R.string.localizable.remove()) { [weak self] (action, view, completionHandler) in
            guard let `self` = self else { return }
            self.viewModel.updateCurrency(self.viewModel.favorites.value[indexPath.row])
            completionHandler(true)
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }

    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.favorites.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: CryptoTableViewCell.self, at: indexPath)
        cell.hideFavorite()
        cell.setData(self.viewModel.favorites.value[indexPath.row])
        return cell
    }
}
