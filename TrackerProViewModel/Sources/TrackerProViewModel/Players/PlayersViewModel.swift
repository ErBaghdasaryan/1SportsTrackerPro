//
//  PlayersViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import Foundation
import TrackerProModel

public protocol IPlayersViewModel {
    
}

public class PlayersViewModel: IPlayersViewModel {

    private let playersService: IPlayersService

    public init(playersService: IPlayersService) {
        self.playersService = playersService
    }
}
