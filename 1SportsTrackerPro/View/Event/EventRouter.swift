//
//  EventRouter.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import Foundation
import UIKit
import TrackerProModel

final class EventRouter: BaseRouter {
    static func showAddEventViewController(in navigationController: UINavigationController, navigationModel: AddNavigationModel) {
        let viewController = ViewControllerFactory.makeAddEventViewController(navigationModel: navigationModel)
        viewController.navigationItem.hidesBackButton = true
        viewController.hidesBottomBarWhenPushed = false
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }

    static func showEditEventViewController(in navigationController: UINavigationController, navigationModel: EventNavigationModel) {
        let viewController = ViewControllerFactory.makeEditEventViewController(navigationModel: navigationModel)
        viewController.navigationItem.hidesBackButton = true
        viewController.hidesBottomBarWhenPushed = false
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
