//
//  PlayersService.swift
//  
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import UIKit
import TrackerProModel
import SQLite

public protocol IPlayersService {
    func addPlayer(_ model: PlayerModel) throws -> PlayerModel
    func getPlayers() throws -> [PlayerModel]
    func deletePlayer(byID id: Int) throws
    func editPlayer(_ player: PlayerModel) throws
}

public class PlayersService: IPlayersService {

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    public init() { }

    public func addPlayer(_ model: PlayerModel) throws -> PlayerModel {
        let db = try Connection("\(path)/db.sqlite3")
        let players = Table("Players")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("image")
        let nameColumn = Expression<String>("name")
        let howLongColumn = Expression<String>("howLong")
        let goalsColumn = Expression<String>("goals")
        let assistanceColumn = Expression<String>("assistance")
        let penaltiesColumn = Expression<String>("penalties")
        let playerNumberColumn = Expression<String>("playerNumber")

        try db.run(players.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(imageColumn)
            t.column(nameColumn)
            t.column(howLongColumn)
            t.column(goalsColumn)
            t.column(assistanceColumn)
            t.column(penaltiesColumn)
            t.column(playerNumberColumn)
        })

        guard let imageData = model.image.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let rowId = try db.run(players.insert(
            imageColumn <- imageData,
            nameColumn <- model.name,
            howLongColumn <- model.howLong,
            goalsColumn <- model.goals,
            assistanceColumn <- model.assistance,
            penaltiesColumn <- model.penalties,
            playerNumberColumn <- model.playerNumber
        ))

        return PlayerModel(id: Int(rowId),
                           image: model.image,
                           name: model.name,
                           howLong: model.howLong,
                           goals: model.goals,
                           assistance: model.assistance,
                           penalties: model.penalties,
                           playerNumber: model.playerNumber)
    }

    public func getPlayers() throws -> [PlayerModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let players = Table("Players")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("image")
        let nameColumn = Expression<String>("name")
        let howLongColumn = Expression<String>("howLong")
        let goalsColumn = Expression<String>("goals")
        let assistanceColumn = Expression<String>("assistance")
        let penaltiesColumn = Expression<String>("penalties")
        let playerNumberColumn = Expression<String>("playerNumber")

        var result: [PlayerModel] = []

        for player in try db.prepare(players) {
            guard let image = UIImage(data: player[imageColumn]) else {
                throw NSError(domain: "ImageConversionError", code: 2, userInfo: nil)
            }

            let fetchedPlayer = PlayerModel(id: player[idColumn],
                                            image: image,
                                            name: player[nameColumn],
                                            howLong: player[howLongColumn],
                                            goals: player[goalsColumn],
                                            assistance: player[assistanceColumn],
                                            penalties: player[penaltiesColumn],
                                            playerNumber: player[playerNumberColumn])

            result.append(fetchedPlayer)
        }

        return result
    }

    public func deletePlayer(byID id: Int) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let players = Table("Players")
        let idColumn = Expression<Int>("id")

        let playerToDelete = players.filter(idColumn == id)
        try db.run(playerToDelete.delete())
    }

    public func editPlayer(_ player: PlayerModel) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let players = Table("Players")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("image")
        let nameColumn = Expression<String>("name")
        let howLongColumn = Expression<String>("howLong")
        let goalsColumn = Expression<String>("goals")
        let assistanceColumn = Expression<String>("assistance")
        let penaltiesColumn = Expression<String>("penalties")
        let playerNumberColumn = Expression<String>("playerNumber")

        guard let imageData = player.image.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let playerToUpdate = players.filter(idColumn == player.id!)
        try db.run(playerToUpdate.update(
            imageColumn <- imageData,
            nameColumn <- player.name,
            howLongColumn <- player.howLong,
            goalsColumn <- player.goals,
            assistanceColumn <- player.assistance,
            penaltiesColumn <- player.penalties,
            playerNumberColumn <- player.playerNumber
        ))
    }

}
