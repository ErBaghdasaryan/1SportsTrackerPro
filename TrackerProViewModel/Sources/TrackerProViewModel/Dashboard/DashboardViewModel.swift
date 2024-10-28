//
//  DashboardViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import Foundation
import TrackerProModel

public protocol IDashboardViewModel {
    
}

public class DashboardViewModel: IDashboardViewModel {

    private let dashboardService: IDashboardService

    public init(dashboardService: IDashboardService) {
        self.dashboardService = dashboardService
    }
}
