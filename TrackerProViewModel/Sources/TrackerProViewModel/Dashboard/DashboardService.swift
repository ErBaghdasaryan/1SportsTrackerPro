//
//  DashboardService.swift
//
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import UIKit
import TrackerProModel
import SQLite

public protocol IDashboardService {
    func getMatches() throws -> [MatchModel]
    func getEvents() throws -> [EventModel]
}

public class DashboardService: IDashboardService {

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    public init() { }

    public func getMatches() throws -> [MatchModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let matches = Table("Matches")
        let idColumn = Expression<Int>("id")
        let firstImageColumn = Expression<Data>("firstImage")
        let firstNameColumn = Expression<String>("firstName")
        let firstScoreColumn = Expression<String>("firstScore")
        let secondImageColumn = Expression<Data>("secondImage")
        let secondNameColumn = Expression<String>("secondName")
        let secondScoreColumn = Expression<String>("secondScore")
        let dateColumn = Expression<String>("date")
        let cityColumn = Expression<String>("city")
        let durationColumn = Expression<String>("duration")
        let penaltiesColumn = Expression<String>("penalties")
        let playerNameColumn = Expression<String>("playerName")
        let playerNumberColumn = Expression<String>("playerNumber")
        let isVictoryColumn = Expression<Bool>("isVictory")

        var result: [MatchModel] = []

        for match in try db.prepare(matches) {
            guard let firstImage = UIImage(data: match[firstImageColumn]) else {
                throw NSError(domain: "ImageConversionError", code: 2, userInfo: nil)
            }

            guard let sceondImage = UIImage(data: match[secondImageColumn]) else {
                throw NSError(domain: "ImageConversionError", code: 2, userInfo: nil)
            }

            let fetchedMatch = MatchModel(id: match[idColumn],
                                          firstName: match[firstNameColumn],
                                          firstImage: firstImage,
                                          firstScore: match[firstScoreColumn],
                                          secondName: match[secondNameColumn],
                                          secondImage: sceondImage,
                                          secondScore: match[secondScoreColumn],
                                          date: match[dateColumn],
                                          city: match[cityColumn],
                                          duration: match[durationColumn],
                                          penalties: match[penaltiesColumn],
                                          playerName: match[playerNameColumn],
                                          playerNumber: match[playerNumberColumn],
                                          isVictory: match[isVictoryColumn])

            result.append(fetchedMatch)
        }

        return result
    }

    public func getEvents() throws -> [EventModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let events = Table("Events")
        let idColumn = Expression<Int>("id")
        let nameColumn = Expression<String>("name")
        let imageColumn = Expression<Data>("image")
        let startTimeColumn = Expression<String>("startTime")
        let dateColumn = Expression<String>("date")

        var result: [EventModel] = []

        for event in try db.prepare(events) {
            guard let image = UIImage(data: event[imageColumn]) else {
                throw NSError(domain: "ImageConversionError", code: 2, userInfo: nil)
            }

            let fetchedEvent = EventModel(id: event[idColumn],
                                          name: event[nameColumn],
                                          image: image,
                                          startTime: event[startTimeColumn],
                                          date: event[dateColumn])

            result.append(fetchedEvent)
        }

        return result
    }
}
