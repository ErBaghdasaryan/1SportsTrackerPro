//
//  StatisticAssembly.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import Foundation
import TrackerProViewModel
import Swinject
import SwinjectAutoregistration

final class StatisticAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IStatisticViewModel.self, initializer: StatisticViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IStatisticService.self, initializer: StatisticService.init)
    }
}
