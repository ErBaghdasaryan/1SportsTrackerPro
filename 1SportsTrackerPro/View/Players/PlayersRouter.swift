//
//  PlayersRouter.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import Foundation
import UIKit
import TrackerProModel

final class PlayersRouter: BaseRouter {
    static func showAddPlayerViewController(in navigationController: UINavigationController, navigationModel: AddNavigationModel) {
        let viewController = ViewControllerFactory.makeAddPlayerViewController(navigationModel: navigationModel)
        viewController.navigationItem.hidesBackButton = true
        viewController.hidesBottomBarWhenPushed = false
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showEditPlayerViewController(in navigationController: UINavigationController, navigationModel: PlayerNavigationModel) {
        let viewController = ViewControllerFactory.makeEditPlayerViewController(navigationModel: navigationModel)
        viewController.navigationItem.hidesBackButton = true
        viewController.hidesBottomBarWhenPushed = false
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
