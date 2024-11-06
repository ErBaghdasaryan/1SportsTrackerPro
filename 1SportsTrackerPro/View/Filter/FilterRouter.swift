//
//  FilterRouter.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import Foundation
import UIKit
import TrackerProViewModel

final class FilterRouter: BaseRouter {
    static func showProfileViewController(in navigationController: UINavigationController) {
        let viewController = ViewControllerFactory.makeProfileViewController()
        viewController.navigationItem.hidesBackButton = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
}
