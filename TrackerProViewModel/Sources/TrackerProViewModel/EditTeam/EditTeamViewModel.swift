//
//  EditTeamViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import Foundation
import TrackerProModel
import Combine

public protocol IEditTeamViewModel {
    func deleteTeam(by id: Int)
    var team: TeamModel { get set }
}

public class EditTeamViewModel: IEditTeamViewModel {

    private let teamService: ITeamService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()
    public var team: TeamModel

    public init(teamService: ITeamService, navigationModel: TeamNavigationModel) {
        self.teamService = teamService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
        self.team = navigationModel.model
    }

    public func deleteTeam(by id: Int) {
        do {
            try self.teamService.deleteTeam(byID: id)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
