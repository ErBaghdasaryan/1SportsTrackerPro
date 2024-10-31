//
//  SelectTeamAssembly.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import Foundation
import TrackerProViewModel
import Swinject
import SwinjectAutoregistration

final class SelectTeamAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(ITeamViewModel.self, initializer: TeamViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(ITeamService.self, initializer: TeamService.init)
    }
}
