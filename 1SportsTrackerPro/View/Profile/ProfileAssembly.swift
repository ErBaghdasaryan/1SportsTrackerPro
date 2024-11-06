//
//  ProfileAssembly.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 06.11.24.
//

import Foundation
import Swinject
import SwinjectAutoregistration
import TrackerProViewModel

final class ProfileAssembly: Assembly {
    func assemble(container: Swinject.Container) {
        registerViewModelServices(in: container)
        registerViewModel(in: container)
    }

    func registerViewModel(in container: Container) {
        container.autoregister(IProfileViewModel.self, initializer: ProfileViewModel.init)
    }

    func registerViewModelServices(in container: Container) {
        container.autoregister(IProfileService.self, initializer: ProfileService.init)
    }
}
