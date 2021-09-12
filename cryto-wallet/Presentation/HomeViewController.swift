//
//  HomeViewController.swift
//  cryto-wallet
//
//  Created by Hoang on 09/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.className)
        view.dataSource = self
        view.rowHeight = UITableView.automaticDimension
        view.separatorStyle = .none
        return view
    }()

    private let searchController = UISearchController(searchResultsController: nil)

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
        self.title = R.string.localizable.market()
        
        // Do any additional setup after loading the view.
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = R.string.localizable.search()
        navigationItem.searchController = searchController
        definesPresentationContext = true

        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { maker in
            maker.leading.trailing.top.bottom.equalToSuperview()
        }

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
          forName: UIResponder.keyboardWillChangeFrameNotification,
          object: nil, queue: .main) { (notification) in
            self.handleKeyboard(notification: notification)
        }
        notificationCenter.addObserver(
          forName: UIResponder.keyboardWillHideNotification,
          object: nil, queue: .main) { (notification) in
            self.handleKeyboard(notification: notification)
        }

        // MARK: Binding
        viewModel.currencies.bind { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

    func handleKeyboard(notification: Notification) {
      guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return
      }

      guard
        let info = notification.userInfo,
        let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
          return
      }

      let keyboardHeight = keyboardFrame.cgRectValue.size.height
      UIView.animate(withDuration: 0.1, animations: { () -> Void in
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
      })
    }

}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        self.viewModel.search(with: searchBar.text ?? "")
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.currencies.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: CryptoTableViewCell.self, at: indexPath)
        cell.setData(self.viewModel.currencies.value[indexPath.row])
        cell.favorited = {[weak self] cell in
            guard let `self` = self, let indexPath = self.tableView.indexPath(for: cell) else {
                return
            }
            let entity = self.viewModel.currencies.value[indexPath.row]
            self.viewModel.updateCurrency(entity)
        }
        return cell
    }
}
