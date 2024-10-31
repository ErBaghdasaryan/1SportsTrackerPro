//
//  AddMatchRouter.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import Foundation
import UIKit
import TrackerProModel

final class AddMatchRouter: BaseRouter {
    static func showSelectTeamViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeSelectTeamsViewController()
        viewController.navigationItem.hidesBackButton = true
        viewController.hidesBottomBarWhenPushed = false
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
