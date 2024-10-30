//
//  TabBarViewModel.swift
//
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit
import TrackerProModel

public protocol ITabBarViewModel {
    var appStorageService: IAppStorageService { get set }
}

public class TabBarViewModel: ITabBarViewModel {

    private let tabBarService: ITabBarService
    public var appStorageService: IAppStorageService

    public init(tabBarService: ITabBarService, appStorageService: IAppStorageService) {
        self.tabBarService = tabBarService
        self.appStorageService = appStorageService
    }
}

