//
//  AddTeamViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import Foundation
import TrackerProModel
import Combine

public protocol IAddTeamViewModel {
    func addTeam(model: TeamModel)
}

public class AddTeamViewModel: IAddTeamViewModel {

    private let teamService: ITeamService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(teamService: ITeamService, navigationModel: AddNavigationModel) {
        self.teamService = teamService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
    }

    public func addTeam(model: TeamModel) {
        do {
            _ = try self.teamService.addTeam(model)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
