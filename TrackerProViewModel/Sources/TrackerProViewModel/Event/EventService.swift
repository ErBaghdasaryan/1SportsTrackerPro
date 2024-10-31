//
//  EventService.swift
//  
//
//  Created by Er Baghdasaryan on 28.10.24.
//

import UIKit
import TrackerProModel
import SQLite

public protocol IEventService {
    func addEvent(_ model: EventModel) throws -> EventModel
    func getEvents() throws -> [EventModel]
    func deleteEvent(byID id: Int) throws
    func editEvent(_ event: EventModel) throws
}

public class EventService: IEventService {

    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    public init() { }

    public func addEvent(_ model: EventModel) throws -> EventModel {
        let db = try Connection("\(path)/db.sqlite3")
        let events = Table("Events")
        let idColumn = Expression<Int>("id")
        let nameColumn = Expression<String>("name")
        let imageColumn = Expression<Data>("image")
        let startTimeColumn = Expression<String>("startTime")
        let dateColumn = Expression<String>("date")

        try db.run(events.create(ifNotExists: true) { t in
            t.column(idColumn, primaryKey: .autoincrement)
            t.column(nameColumn)
            t.column(imageColumn)
            t.column(startTimeColumn)
            t.column(dateColumn)
        })

        guard let imageData = model.image.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let rowId = try db.run(events.insert(
            nameColumn <- model.name,
            imageColumn <- imageData,
            startTimeColumn <- model.startTime,
            dateColumn <- model.date
        ))

        return EventModel(id: Int(rowId),
                          name: model.name,
                          image: model.image,
                          startTime: model.startTime,
                          date: model.date)
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

    public func deleteEvent(byID id: Int) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let events = Table("Events")
        let idColumn = Expression<Int>("id")

        let eventToDelete = events.filter(idColumn == id)
        try db.run(eventToDelete.delete())
    }

    public func editEvent(_ event: EventModel) throws {
        let db = try Connection("\(path)/db.sqlite3")
        let events = Table("Events")
        let idColumn = Expression<Int>("id")
        let nameColumn = Expression<String>("name")
        let imageColumn = Expression<Data>("image")
        let startTimeColumn = Expression<String>("startTime")
        let dateColumn = Expression<String>("date")

        guard let imageData = event.image.pngData() else {
            throw NSError(domain: "ImageConversionError", code: 1, userInfo: nil)
        }

        let evnetToUpdate = events.filter(idColumn == event.id!)
        try db.run(evnetToUpdate.update(
            nameColumn <- event.name,
            imageColumn <- imageData,
            startTimeColumn <- event.startTime,
            dateColumn <- event.date
        ))
    }

}
