//
//  StatisticViewModel.swift
//
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import Foundation
import TrackerProModel

public protocol IStatisticViewModel {
    
}

public class StatisticViewModel: IStatisticViewModel {

    private let statisticService: IStatisticService

    public init(statisticService: IStatisticService) {
        self.statisticService = statisticService
    }
}
