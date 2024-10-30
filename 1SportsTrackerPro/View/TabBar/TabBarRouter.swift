//
//  TabBarRouter.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 29.10.24.
//

import UIKit
import TrackerProModel

final class TabBarRouter: BaseRouter {

    static func showSettingsViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeSettingsViewController()
        viewController.navigationItem.hidesBackButton = true
        viewController.hidesBottomBarWhenPushed = false
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showTeamViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeTeamsViewController()
        viewController.navigationItem.hidesBackButton = true
        viewController.hidesBottomBarWhenPushed = false
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showChooseTeamViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeChooseTeamsViewController()
        viewController.navigationItem.hidesBackButton = true
        viewController.hidesBottomBarWhenPushed = false
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
