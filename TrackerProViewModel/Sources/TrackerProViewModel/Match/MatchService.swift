//
//  MatchService.swift
//  
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import UIKit
import TrackerProModel
import SQLite

public protocol IMatchService {
    func addMatch(_ model: MatchModel) throws -> MatchModel
    func getMatches() throws -> [MatchModel]
    func deleteMatch(byID id: Int) throws
    func editMatch(_ match: MatchModel) throws
}

public class MatchService: IMatchService {

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    public init() { }

    public func addMatch(_ model: MatchModel) throws -> MatchModel {
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

        try db.run(matches.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(firstImageColumn)
            t.column(firstNameColumn)
            t.column(firstScoreColumn)
            t.column(secondImageColumn)
            t.column(secondNameColumn)
            t.column(secondScoreColumn)
            t.column(dateColumn)
            t.column(cityColumn)
            t.column(durationColumn)
            t.column(penaltiesColumn)
            t.column(playerNameColumn)
            t.column(playerNumberColumn)
            t.column(isVictoryColumn)
        })

        guard let firstImageData = model.firstImage.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        guard let secondImageData = model.secondImage.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let rowId = try db.run(matches.insert(
            firstImageColumn <- firstImageData,
            firstNameColumn <- model.firstName,
            firstScoreColumn <- model.firstScore,
            secondImageColumn <- secondImageData,
            secondNameColumn <- model.secondName,
            secondScoreColumn <- model.secondScore,
            dateColumn <- model.date,
            cityColumn <- model.city,
            durationColumn <- model.duration,
            penaltiesColumn <- model.penalties,
            playerNameColumn <- model.playerName,
            playerNumberColumn <- model.playerNumber,
            isVictoryColumn <- model.isVictory
        ))

        return MatchModel(id: Int(rowId),
                          firstName: model.firstName,
                          firstImage: model.firstImage,
                          firstScore: model.firstScore,
                          secondName: model.secondName,
                          secondImage: model.secondImage,
                          secondScore: model.secondScore,
                          date: model.date,
                          city: model.city,
                          duration: model.duration,
                          penalties: model.penalties,
                          playerName: model.playerName,
                          playerNumber: model.playerNumber,
                          isVictory: model.isVictory)
    }

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

    public func deleteMatch(byID id: Int) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let matches = Table("Matches")
        let idColumn = Expression<Int>("id")

        let matchToDelete = matches.filter(idColumn == id)
        try db.run(matchToDelete.delete())
    }

    public func editMatch(_ match: MatchModel) throws {
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

        guard let firstImageData = match.firstImage.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        guard let secondImageData = match.secondImage.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let matchToUpdate = matches.filter(idColumn == match.id!)
        try db.run(matchToUpdate.update(
            firstImageColumn <- firstImageData,
            firstNameColumn <- match.firstName,
            firstScoreColumn <- match.firstScore,
            secondImageColumn <- secondImageData,
            secondNameColumn <- match.secondName,
            secondScoreColumn <- match.secondScore,
            dateColumn <- match.date,
            cityColumn <- match.city,
            durationColumn <- match.duration,
            penaltiesColumn <- match.penalties,
            playerNameColumn <- match.playerName,
            playerNumberColumn <- match.playerNumber,
            isVictoryColumn <- match.isVictory
        ))
    }

}
