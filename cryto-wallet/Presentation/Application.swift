//
//  Application.swift
//  cryto-wallet
//
//  Created by Hoang on 11/09/2021.
//  Copyright © 2021 Phan Quang Hoang. All rights reserved.
//

import UIKit

final class Application {
    static let shared = Application()

    private let usecaseProvider: UseCaseProvider

    private init() {
        self.usecaseProvider = DefaultUseCaseProvider()
    }
    
    func configureMainInterface(in window: UIWindow) {
        let viewModel = DefaultCurrencyViewModel(with: usecaseProvider.makeCurrencyUsecase(),
                                                favoriteUseCase: usecaseProvider.makeFavoriteUseCase()
        )
        let homeVC = HomeViewController(with: viewModel)

        let homeItem = UITabBarItem()
        homeItem.title = R.string.localizable.explore()
        homeItem.image = R.image.ic_home()
        homeVC.tabBarItem = homeItem

        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        homeNavigationController.tabBarItem = homeItem
        homeNavigationController.navigationBar.prefersLargeTitles = true

        let favoriteVC = FavoriteViewController(with: viewModel)
        let favoriteItem = UITabBarItem()
        favoriteItem.title = R.string.localizable.favorite()
        favoriteItem.image = R.image.ic_watch_list()

        let favoriteNavigationController = UINavigationController(rootViewController: favoriteVC)
        favoriteNavigationController.tabBarItem = favoriteItem
        favoriteNavigationController.navigationBar.prefersLargeTitles = true

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            homeNavigationController,
            favoriteNavigationController,
        ]
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
