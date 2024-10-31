//
//  AddPlayerViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import Foundation
import TrackerProModel
import Combine

public protocol IAddPlayerViewModel {
    func addPlayer(model: PlayerModel)
    var appStorageService: IAppStorageService { get set }
}

public class AddPlayerViewModel: IAddPlayerViewModel {

    private let playersService: IPlayersService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()
    public var appStorageService: IAppStorageService

    public init(playersService: IPlayersService, navigationModel: AddNavigationModel, appStorageService: IAppStorageService) {
        self.playersService = playersService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
        self.appStorageService = appStorageService
    }

    public func addPlayer(model: PlayerModel) {
        do {
            _ = try self.playersService.addPlayer(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
