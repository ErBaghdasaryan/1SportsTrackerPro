//
//  DetailRouter.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import Foundation
import UIKit
import TrackerProViewModel

final class DetailRouter: BaseRouter {
    static func showFilterViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeFilterViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }
}
