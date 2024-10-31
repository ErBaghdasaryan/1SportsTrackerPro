//
//  AddMatchAssembly.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import Foundation
import TrackerProViewModel
import TrackerProModel
import Swinject
import SwinjectAutoregistration

final class AddMatchAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IAddMatchViewModel.self, argument: AddNavigationModel.self, initializer: AddMatchViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IMatchService.self, initializer: MatchService.init)
    }
}
