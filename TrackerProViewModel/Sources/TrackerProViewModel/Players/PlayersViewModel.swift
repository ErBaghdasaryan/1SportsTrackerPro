//
//  PlayersViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import Foundation
import TrackerProModel
import Combine

public protocol IPlayersViewModel {
    func loadData()
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
    var players: [PlayerModel] { get set }
}

public class PlayersViewModel: IPlayersViewModel {

    private let playersService: IPlayersService
    public var players: [PlayerModel] = []
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(playersService: IPlayersService) {
        self.playersService = playersService
    }

    public func loadData() {
        do {
            self.players = try self.playersService.getPlayers()
        } catch {
            print(error)
        }
    }
}
