//
//  MatchViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import Foundation
import TrackerProModel
import Combine

public protocol IMatchViewModel {
    func loadData()
    var activateSuccessSubject: PassthroughSubject<Bool, Never> { get }
    var matches: [MatchModel] { get set }
}

public class MatchViewModel: IMatchViewModel {

    private let matchService: IMatchService
    public var matches: [MatchModel] = []
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()

    public init(matchService: IMatchService) {
        self.matchService = matchService
    }

    public func loadData() {
        do {
            self.matches = try self.matchService.getMatches()
        } catch {
            print(error)
        }
    }
}
