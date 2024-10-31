//
//  EditEventAssembly.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 31.10.24.
//


import Foundation
import TrackerProViewModel
import TrackerProModel
import Swinject
import SwinjectAutoregistration

final class EditEventAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IEditEventViewModel.self, argument: EventNavigationModel.self, initializer: EditEventViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IEventService.self, initializer: EventService.init)
    }
}
