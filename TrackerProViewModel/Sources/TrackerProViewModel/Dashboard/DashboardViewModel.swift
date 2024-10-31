//
//  DashboardViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import Foundation
import TrackerProModel

public protocol IDashboardViewModel {
    func loadMatches()
    var matche: MatchModel? { get set }
    func loadEvents()
    var event: EventModel? { get set }
    var wonMatchesCount: Int { get }
    var totalScore: Int { get }
    var lostMatchesCount: Int { get }
    var playerName: String? { get }
    var playerNumber: String? { get }
}

public class DashboardViewModel: IDashboardViewModel {

    private let dashboardService: IDashboardService
    public var matche: MatchModel?
    public var event: EventModel?
    private var matches: [MatchModel] = []

    public var wonMatchesCount: Int {
        return matches.filter { $0.isVictory }.count
    }

    public var lostMatchesCount: Int {
        return matches.filter { !$0.isVictory }.count
    }

    public var totalScore: Int {
        return matches.reduce(0) { $0 + $1.totalScore }
    }

    public var playerName: String? {
        return matches.last?.playerName
    }

    public var playerNumber: String? {
        return matches.last?.playerNumber
    }

    public init(dashboardService: IDashboardService) {
        self.dashboardService = dashboardService
    }

    public func loadMatches() {
        do {
            self.matches = try self.dashboardService.getMatches()
            self.matche = self.matches.last
        } catch {
            print(error)
        }
    }

    public func loadEvents() {
        do {
            self.event = try self.dashboardService.getEvents().last
        } catch {
            print(error)
        }
    }
}
