//
//  EditEventViewModel.swift
//  
//
//  Created by Er Baghdasaryan on 31.10.24.
//

import Foundation
import TrackerProModel
import Combine

public protocol IEditEventViewModel {
    func deleteEvent(by id: Int)
    var event: EventModel { get set }
}

public class EditEventViewModel: IEditEventViewModel {

    private let eventService: IEventService
    public var activateSuccessSubject = PassthroughSubject<Bool, Never>()
    public var event: EventModel

    public init(eventService: IEventService, navigationModel: EventNavigationModel) {
        self.eventService = eventService
        self.activateSuccessSubject = navigationModel.activateSuccessSubject
        self.event = navigationModel.model
    }

    public func deleteEvent(by id: Int) {
        do {
            try self.eventService.deleteEvent(byID: id)
            self.activateSuccessSubject.send(true)
        } catch {
            print(error)
        }
    }
}
