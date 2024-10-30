//
//  TabBarAssembly.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import Foundation
import TrackerProModel
import TrackerProViewModel
import Swinject
import SwinjectAutoregistration

final class TabBarAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(ITabBarViewModel.self, initializer: TabBarViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(ITabBarService.self, initializer: TabBarService.init)
    }
}
