//
//  SettingsRouter.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 29.10.24.
//

import Foundation
import UIKit
import TrackerProViewModel

final class SettingsRouter: BaseRouter {
    static func showUsageViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeUsageViewController()
        navigationController.navigationBar.isHidden = false
        navigationController.navigationItem.hidesBackButton = false
        navigationController.pushViewController(viewController, animated: true)
    }
}
