//
//  ViewControllerFactory.swift
//  1SportsTrackerPro
//
//  Created by Er Baghdasaryan on 25.10.24.
//

import Foundation
import Swinject
import TrackerProViewModel
import TrackerProModel

final class ViewControllerFactory {
    private static let commonAssemblies: [Assembly] = [ServiceAssembly()]

    //MARK: - UntilOnboarding
    static func makeUntilOnboardingViewController() -> UntilOnboardingViewController {
        let assembler = Assembler(commonAssemblies + [UntilOnboardingAssembly()])
        let viewController = UntilOnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IUntilOnboardingViewModel.self)
        return viewController
    }

    //MARK: Onboarding
    static func makeOnboardingViewController() -> OnboardingViewController {
        let assembler = Assembler(commonAssemblies + [OnboardingAssembly()])
        let viewController = OnboardingViewController()
        viewController.viewModel = assembler.resolver.resolve(IOnboardingViewModel.self)
        return viewController
    }

    //MARK: - TabBar
    static func makeTabBarViewController() -> TabBarViewController {
        let viewController = TabBarViewController()
        return viewController
    }

    //MARK: Dashboard
    static func makeDashboardViewController() -> DashboardViewController {
        let assembler = Assembler(commonAssemblies + [DashboardAssembly()])
        let viewController = DashboardViewController()
        viewController.viewModel = assembler.resolver.resolve(IDashboardViewModel.self)
        return viewController
    }

    //MARK: Match
    static func makeMatchViewController() -> MatchViewController {
        let assembler = Assembler(commonAssemblies + [MatchAssembly()])
        let viewController = MatchViewController()
        viewController.viewModel = assembler.resolver.resolve(IMatchViewModel.self)
        return viewController
    }

    //MARK: Event
    static func makeEventViewController() -> EventViewController {
        let assembler = Assembler(commonAssemblies + [EventAssembly()])
        let viewController = EventViewController()
        viewController.viewModel = assembler.resolver.resolve(IEventViewModel.self)
        return viewController
    }

    //MARK: Statistic
    static func makeStatisticViewController() -> StatisticViewController {
        let assembler = Assembler(commonAssemblies + [StatisticAssembly()])
        let viewController = StatisticViewController()
        viewController.viewModel = assembler.resolver.resolve(IStatisticViewModel.self)
        return viewController
    }

    //MARK: Players
    static func makePlayersViewController() -> PlayersViewController {
        let assembler = Assembler(commonAssemblies + [PlayersAssembly()])
        let viewController = PlayersViewController()
        viewController.viewModel = assembler.resolver.resolve(IPlayersViewModel.self)
        return viewController
    }
}
