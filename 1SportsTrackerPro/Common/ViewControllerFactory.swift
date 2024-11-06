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
        let assembler = Assembler(commonAssemblies + [TabBarAssembly()])
        let viewController = TabBarViewController()
        viewController.viewModel = assembler.resolver.resolve(ITabBarViewModel.self)
        return viewController
    }

    //MARK: Settings
    static func makeSettingsViewController() -> SettingsViewController {
        let assembler = Assembler(commonAssemblies + [SettingsAssembly()])
        let viewController = SettingsViewController()
        viewController.viewModel = assembler.resolver.resolve(ISettingsViewModel.self)
        return viewController
    }

    static func makeUsageViewController() -> UsageViewController {
        let viewController = UsageViewController()
        return viewController
    }


    //MARK: Teams
    static func makeTeamsViewController() -> TeamViewController {
        let assembler = Assembler(commonAssemblies + [TeamAssembly()])
        let viewController = TeamViewController()
        viewController.viewModel = assembler.resolver.resolve(ITeamViewModel.self)
        return viewController
    }

    static func makeChooseTeamsViewController() -> ChooseTeamViewController {
        let assembler = Assembler(commonAssemblies + [ChooseTeamAssembly()])
        let viewController = ChooseTeamViewController()
        viewController.viewModel = assembler.resolver.resolve(ITeamViewModel.self)
        return viewController
    }

    static func makeSelectTeamsViewController() -> SelectTeamViewController {
        let assembler = Assembler(commonAssemblies + [SelectTeamAssembly()])
        let viewController = SelectTeamViewController()
        viewController.viewModel = assembler.resolver.resolve(ITeamViewModel.self)
        return viewController
    }

    static func makeAddTeamViewController(navigationModel: AddNavigationModel) -> AddTeamViewController {
        let assembler = Assembler(commonAssemblies + [AddTeamAssembly()])
        let viewController = AddTeamViewController()
        viewController.viewModel = assembler.resolver.resolve(IAddTeamViewModel.self, argument: navigationModel)
        return viewController
    }

    static func makeEditTeamViewController(navigationModel: TeamNavigationModel) -> EditTeamViewController {
        let assembler = Assembler(commonAssemblies + [EditTeamAssembly()])
        let viewController = EditTeamViewController()
        viewController.viewModel = assembler.resolver.resolve(IEditTeamViewModel.self, argument: navigationModel)
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

    static func makeAddMatchViewController(navigationModel: AddNavigationModel) -> AddMatchViewController {
        let assembler = Assembler(commonAssemblies + [AddMatchAssembly()])
        let viewController = AddMatchViewController()
        viewController.viewModel = assembler.resolver.resolve(IAddMatchViewModel.self, argument: navigationModel)
        return viewController
    }

    static func makeEditMatchViewController(navigationModel: MatchNavigatioModel) -> EditMatchViewController {
        let assembler = Assembler(commonAssemblies + [EditMatchAssembly()])
        let viewController = EditMatchViewController()
        viewController.viewModel = assembler.resolver.resolve(IEditMatchViewModel.self, argument: navigationModel)
        return viewController
    }

    //MARK: Event
    static func makeEventViewController() -> EventViewController {
        let assembler = Assembler(commonAssemblies + [EventAssembly()])
        let viewController = EventViewController()
        viewController.viewModel = assembler.resolver.resolve(IEventViewModel.self)
        return viewController
    }

    static func makeAddEventViewController(navigationModel: AddNavigationModel) -> AddEventViewController {
        let assembler = Assembler(commonAssemblies + [AddEventAssembly()])
        let viewController = AddEventViewController()
        viewController.viewModel = assembler.resolver.resolve(IAddEventViewModel.self, argument: navigationModel)
        return viewController
    }

    static func makeEditEventViewController(navigationModel: EventNavigationModel) -> EditEventViewController {
        let assembler = Assembler(commonAssemblies + [EditEventAssembly()])
        let viewController = EditEventViewController()
        viewController.viewModel = assembler.resolver.resolve(IEditEventViewModel.self, argument: navigationModel)
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

    static func makeAddPlayerViewController(navigationModel: AddNavigationModel) -> AddPlayerViewController {
        let assembler = Assembler(commonAssemblies + [AddPlayerAssembly()])
        let viewController = AddPlayerViewController()
        viewController.viewModel = assembler.resolver.resolve(IAddPlayerViewModel.self, argument: navigationModel)
        return viewController
    }

    static func makeEditPlayerViewController(navigationModel: PlayerNavigationModel) -> EditPlayerViewController {
        let assembler = Assembler(commonAssemblies + [EditPlayerAssembly()])
        let viewController = EditPlayerViewController()
        viewController.viewModel = assembler.resolver.resolve(IEditPlayerViewModel.self, argument: navigationModel)
        return viewController
    }

    //MARK: Details
    static func makeDetailsViewController() -> DetailViewController {
        let assembler = Assembler(commonAssemblies + [DetailAssembly()])
        let viewController = DetailViewController()
        viewController.viewModel = assembler.resolver.resolve(IDetailViewModel.self)
        return viewController
    }

    //MARK: Filter
    static func makeFilterViewController() -> FilterViewController {
        let assembler = Assembler(commonAssemblies + [FilterAssembly()])
        let viewController = FilterViewController()
        viewController.viewModel = assembler.resolver.resolve(IFilterViewModel.self)
        return viewController
    }

    //MARK: Profile
    static func makeProfileViewController() -> ProfileViewController {
        let assembler = Assembler(commonAssemblies + [ProfileAssembly()])
        let viewController = ProfileViewController()
        viewController.viewModel = assembler.resolver.resolve(IProfileViewModel.self)
        return viewController
    }
}
