//
//  EditPlayerViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import Foundation
import TrackerProModel
import Combine

public protocol IEditPlayerViewModel {
    func deletePlayer(by id: Int)
    var player: PlayerModel { get set }
}

public class EditPlayerViewModel: IEditPlayerViewModel {

    private let playersService: IPlayersService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()
    public var player: PlayerModel

    public init(playersService: IPlayersService, navigationModel: PlayerNavigationModel) {
        self.playersService = playersService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
        self.player = navigationModel.model
    }

    public func deletePlayer(by id: Int) {
        do {
            try self.playersService.deletePlayer(byID: id)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
