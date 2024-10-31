//
//  MatchRouter.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import Foundation
import UIKit
import TrackerProModel

final class MatchRouter: BaseRouter {
    static func showAddMatchViewController(in navigationController: UINavigationController, navigationModel: AddNavigationModel) {
        let viewController = ViewControllerFactory.makeAddMatchViewController(navigationModel: navigationModel)
        viewController.navigationItem.hidesBackButton = true
        viewController.hidesBottomBarWhenPushed = false
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showEditmatchViewController(in navigationController: UINavigationController, navigationModel: MatchNavigatioModel) {
        let viewController = ViewControllerFactory.makeEditMatchViewController(navigationModel: navigationModel)
        viewController.navigationItem.hidesBackButton = true
        viewController.hidesBottomBarWhenPushed = false
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
