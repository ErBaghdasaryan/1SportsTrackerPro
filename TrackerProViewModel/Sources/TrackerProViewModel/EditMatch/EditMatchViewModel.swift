//
//  EditMatchViewModel.swift
//
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import Foundation
import TrackerProModel
import Combine

public protocol IEditMatchViewModel {
    func deleteMatch(by id: Int)
    var match: MatchModel { get set }
}

public class EditMatchViewModel: IEditMatchViewModel {

    private let matchService: IMatchService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()
    public var match: MatchModel

    public init(matchService: IMatchService, navigationModel: MatchNavigatioModel) {
        self.matchService = matchService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
        self.match = navigationModel.model
    }

    public func deleteMatch(by id: Int) {
        do {
            try self.matchService.deleteMatch(byID: id)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
