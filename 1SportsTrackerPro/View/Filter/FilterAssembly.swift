//
//  FilterAssembly.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import Foundation
import TrackerProViewModel
import Swinject
import SwinjectAutoregistration

final class FilterAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IFilterViewModel.self, initializer: FilterViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IFilterService.self, initializer: FilterService.init)
    }
}
