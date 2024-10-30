//
//  AddTeamAssembly.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import Foundation
import TrackerProViewModel
import TrackerProModel
import Swinject
import SwinjectAutoregistration

final class AddTeamAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IAddTeamViewModel.self, argument: AddNavigationModel.self, initializer: AddTeamViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(ITeamService.self, initializer: TeamService.init)
    }
}
