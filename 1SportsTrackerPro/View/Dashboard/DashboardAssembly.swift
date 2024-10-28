//
//  DashboardAssembly.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import Foundation
import TrackerProViewModel
import Swinject
import SwinjectAutoregistration

final class DashboardAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IDashboardViewModel.self, initializer: DashboardViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IDashboardService.self, initializer: DashboardService.init)
    }
}
