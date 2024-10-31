//
//  EditMatchAssembly.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import Foundation
import TrackerProViewModel
import TrackerProModel
import Swinject
import SwinjectAutoregistration

final class EditMatchAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IEditMatchViewModel.self, argument: MatchNavigatioModel.self, initializer: EditMatchViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IMatchService.self, initializer: MatchService.init)
    }
}
