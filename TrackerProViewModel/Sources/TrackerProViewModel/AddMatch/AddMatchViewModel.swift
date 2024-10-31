//
//  AddMatchViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import Foundation
import TrackerProModel
import Combine

public protocol IAddMatchViewModel {
    func addMatch(model: MatchModel)
    var appStorageService: IAppStorageService { get set }
}

public class AddMatchViewModel: IAddMatchViewModel {

    private let matchService: IMatchService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()
    public var appStorageService: IAppStorageService

    public init(matchService: IMatchService, navigationModel: AddNavigationModel, appStorageService: IAppStorageService) {
        self.matchService = matchService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
        self.appStorageService = appStorageService
    }

    public func addMatch(model: MatchModel) {
        do {
            _ = try self.matchService.addMatch(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
