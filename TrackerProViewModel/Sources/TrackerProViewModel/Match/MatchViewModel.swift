//
//  MatchViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import Foundation
import TrackerProModel

public protocol IMatchViewModel {
    
}

public class MatchViewModel: IMatchViewModel {

    private let matchService: IMatchService

    public init(matchService: IMatchService) {
        self.matchService = matchService
    }
}
