//
//  TeamService.swift
//  
//
//  Created by Er Baghdasaryan on 30.10.24.
//

import UIKit
import TrackerProModel
import SQLite

public protocol ITeamService {
    func addTeam(_ model: TeamModel) throws -> TeamModel
    func getTeams() throws -> [TeamModel]
    func deleteTeam(byID id: Int) throws
    func editTeam(_ team: TeamModel) throws
}

public class TeamService: ITeamService {

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    public init() { }

    public func addTeam(_ model: TeamModel) throws -> TeamModel {
        let db = try Connection("\(path)/db.sqlite3")
        let teams = Table("Teams")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("image")
        let titleColumn = Expression<String>("title")

        try db.run(teams.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(imageColumn)
            t.column(titleColumn)
        })

        guard let imageData = model.image.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let rowId = try db.run(teams.insert(
            imageColumn <- imageData,
            titleColumn <- model.title
        ))

        return TeamModel(id: Int(rowId),
                             image: model.image,
                             title: model.title)
    }

    public func getTeams() throws -> [TeamModel] {
        let db = try Connection("\(path)/db.sqlite3")
        let teams = Table("Teams")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("image")
        let titleColumn = Expression<String>("title")

        var result: [TeamModel] = []

        for team in try db.prepare(teams) {
            guard let image = UIImage(data: team[imageColumn]) else {
                throw NSError(domain: "ImageConversionError", code: 2, userInfo: nil)
            }

            let fetchedTeam = TeamModel(id: team[idColumn],
                                        image: image,
                                        title: team[titleColumn])

            result.append(fetchedTeam)
        }

        return result
    }

    public func deleteTeam(byID id: Int) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let teams = Table("Teams")
        let idColumn = Expression<Int>("id")

        let teamToDelete = teams.filter(idColumn == id)
        try db.run(teamToDelete.delete())
    }

    public func editTeam(_ team: TeamModel) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let teams = Table("Teams")
        let idColumn = Expression<Int>("id")
        let imageColumn = Expression<Data>("image")
        let titleColumn = Expression<String>("title")

        guard let imageData = team.image.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let teamToUpdate = teams.filter(idColumn == team.id!)
        try db.run(teamToUpdate.update(
            imageColumn <- imageData,
            titleColumn <- team.title
        ))
    }

}
